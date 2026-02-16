import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:connect/core/widgets/input_field/input_field.dart';
import 'package:connect/features/auth/providers/signup_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PasswordScreen extends ConsumerWidget {
  PasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cnfPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final passwordState = ref.watch(signupControllerProvider);
    final passwordCtrl = ref.read(signupControllerProvider.notifier);

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppTheme.whiteBackground,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.06),
                    child: Text("Create Password", style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w700
                    ),),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                InputField(
                  hintText: "Password", 
                  prefixIcon: Icon(Icons.lock),
                  isPassword: true, 
                  textController: _passwordController,
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.07,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Please provide the password";
                    }

                    if(value.length < 6 || value.length > 12) {
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
          
                SizedBox(
                  height: screenHeight * 0.04,
                ),
          
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.06),
                    child: Text("Confirm Password", style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w700
                    ),),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                InputField(
                  hintText: "Confirm Password", 
                  prefixIcon: Icon(Icons.lock),
                  isPassword: true, 
                  textController: _cnfPasswordController,
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.07,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Please provide the confirmation password";
                    }

                    if(_passwordController.text != _cnfPasswordController.text) {
                      return "Password and Confirmation password should be same";
                    }

                    return null;
                  },
                ),
          
                Spacer(),
          
                 AppButton(
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.06,
                  text: "Create Password",
                  buttonColor: AppTheme.themeRed,
                  textColor: AppTheme.whiteBackground,
                  fontSize: screenWidth * 0.04,
                  onPress: () async{
                    if(formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      final isSuccess = await passwordCtrl.createPassword(_passwordController.text);
                      if(isSuccess && context.mounted) {
                        context.push("/profile");
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: const Text("Failed to create password")
                          ) );
                      // context.push("/profile");
                      }
                    } 
                  },
                ),
          
                SizedBox(
                  height: screenHeight * 0.02,
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}