import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:connect/core/widgets/input_field/input_field.dart';
import 'package:connect/core/widgets/loader_dialog/loader_dialog.dart';
import 'package:connect/core/widgets/pop_up_dialog/pop_up_dialog.dart';
import 'package:connect/features/auth/controllers/signup_controller.dart';
import 'package:connect/shared/providers/signup_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupCtrl = ref.read(signupControllerProvider.notifier);

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    ref.listen<SignupState>(signupControllerProvider, (prev, next) {
      if (next.loading == true) {
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: AppTheme.loaderBackground,
          builder: (_) => const ImageLoaderDialog(),
        );
      }

      if (prev?.loading == true && next.loading == false) {
        context.pop();
      }

      if (next.success && context.mounted) {
        context.push("/verify-otp", extra: _emailController.text);
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
                  "Signup",
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
                      return "Please provide the email";
                    }

                    if (!value.contains("@")) {
                      return "Please provide the valid gmail address";
                    }

                    return null;
                  },
                ),

                SizedBox(height: screenHeight * 0.02),

                InputField(
                  hintText: "Full Name",
                  prefixIcon: Icon(Icons.person),
                  textController: _nameController,
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.07,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please provide your full name";
                    }

                    return null;
                  },
                ),

                SizedBox(height: screenHeight * 0.01),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: AppTheme.themeRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                Spacer(),

                SizedBox(
                  width: screenWidth * 0.85,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: AppTheme.blackBackground,
                        fontWeight: FontWeight.w500,
                        wordSpacing: 0.6,
                      ),
                      children: [
                        TextSpan(text: "By continuing, you agree to our "),

                        TextSpan(
                          text: "User Agreement",
                          style: TextStyle(
                            color: AppTheme.themeRed,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),

                        TextSpan(
                          text: " and acknowledge that you understand the ",
                        ),

                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: AppTheme.themeRed,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                AppButton(
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.06,
                  text: "Continue",
                  buttonColor: AppTheme.themeRed,
                  textColor: AppTheme.whiteBackground,
                  fontSize: screenWidth * 0.04,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => PopUpDialog(
                          title: "Verify Email",
                          body: "Confirm your email address",
                          email: _emailController.text,
                          onConfirm: () async {
                            await signupCtrl.signup(
                              _emailController.text,
                              _nameController.text,
                            );

                            if (context.mounted) {
                              context.pop();
                            }
                          },
                        ),
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
