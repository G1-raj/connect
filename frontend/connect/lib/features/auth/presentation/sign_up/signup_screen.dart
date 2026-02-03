import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:connect/core/widgets/input_field/input_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                //Logo
                 Container(
                  width: screenWidth * 0.4,
                  height: screenWidth * 0.35,
                  decoration: BoxDecoration(
                     color: AppTheme.themeRed,
                     shape: BoxShape.circle
                  ),
          
                  child: Center(
                    child: Text(
                      "M",
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        color: AppTheme.greyColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.01,
                ),
          
                Text("Signup", style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w600
                ),),

                SizedBox(
                  height: screenHeight * 0.05,
                ),

                InputField(
                  hintText: "Email", 
                  prefixIcon: Icon(Icons.email), 
                  textController: _emailController,
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.07,
                ),

                SizedBox(
                  height: screenHeight * 0.02,
                ),

                InputField(
                  hintText: "Full Name", 
                  prefixIcon: Icon(Icons.person), 
                  textController: _nameController,
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.07,
                ),

                SizedBox(
                  height: screenHeight * 0.01,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(onPressed: () {
                      context.pop();
                    }, child: Text("Login", style: TextStyle(
                      color: AppTheme.themeRed,
                      fontWeight: FontWeight.bold
                    ),))
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
                        wordSpacing: 0.6
                      ),
                      children: [
                        TextSpan(
                          text: "By continuing, you agree to our ",
                        ),
                  
                        TextSpan(
                          text: "User Agreement",
                          style: TextStyle(
                            color: AppTheme.themeRed,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline
                          )
                        ),
                  
                        TextSpan(
                          text: " and acknowledge that you understand the "
                        ),
                  
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: AppTheme.themeRed,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline
                          )
                        ),
                  
                  
                      ]
                    ),
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.03,
                ),
          
                AppButton(
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.06,
                  text: "Signup",
                  buttonColor: AppTheme.themeRed,
                  textColor: AppTheme.whiteBackground,
                  fontSize: screenWidth * 0.04,
                ),
          
                SizedBox(
                  height: screenHeight * 0.02,
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}