import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:connect/core/widgets/input_field/input_field.dart';
import 'package:connect/core/widgets/loader_dialog/loader_dialog.dart';
import 'package:connect/features/auth/controllers/login_controller.dart';
import 'package:connect/shared/providers/login_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginControllerProvider);
    final loginCtrl = ref.read(loginControllerProvider.notifier);

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    ref.listen<LoginState>(loginControllerProvider, (prev, next) {
      if (next.loading == true) {
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: AppTheme.loaderBackground,
          builder: (_) => const ImageLoaderDialog(),
        );
      }

      if (prev?.loading == true && next.loading == false) {
        Navigator.pop(context);
      }

      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(next.error!)),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppTheme.whiteBackground,

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.04),
                //Logo
                Hero(
                  tag: "logo",
                  child: Image(
                    image: AssetImage("lib/assets/logo.png"),
                    width: 180,
                  ),
                ),

                SizedBox(height: screenHeight * 0.01),

                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                InputField(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  textController: _emailController,
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.07,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please provide the valid email address";
                    }

                    if (!value.contains("@gmail.com")) {
                      return "Invalid Email";
                    }
                    return null;
                  },
                ),

                SizedBox(height: screenHeight * 0.02),

                InputField(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  isPassword: true,
                  textController: _passwordController,
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.07,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please provide the password";
                    }

                    if (value.length < 6 || value.length > 12) {
                      return "Password length must between 6 to 12 characters";
                    }

                    final hasUpper = RegExp(r'[A-Z]');
                    final hasLower = RegExp(r'[a-z]');
                    final hasDigit = RegExp(r'[0-9]');
                    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

                    if (!hasUpper.hasMatch(value)) {
                      return "Must contain at least one capital letter";
                    }

                    if (!hasLower.hasMatch(value)) {
                      return "Must contain at least one small letter";
                    }

                    if (!hasDigit.hasMatch(value)) {
                      return "Must contain at least one number";
                    }

                    if (!hasSpecial.hasMatch(value)) {
                      return "Must contain at least one special character";
                    }

                    return null;
                  },
                ),

                SizedBox(height: screenHeight * 0.01),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Signup",
                        style: TextStyle(
                          color: AppTheme.themeRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                Spacer(),

                AppButton(
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.06,
                  text: loginState.loading ? "Please wait...." : "Login",
                  buttonColor: AppTheme.themeRed,
                  textColor: AppTheme.whiteBackground,
                  fontSize: screenWidth * 0.04,
                  onPress: loginState.loading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            loginCtrl.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                ),

                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
