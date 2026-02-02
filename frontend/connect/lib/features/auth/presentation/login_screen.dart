import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppTheme.whiteBackground,

      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

              Text("Login", style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.w600
              ),),

              SizedBox(
                height: screenHeight * 0.4,
              ),

              AppButton(
                width: screenWidth * 0.95,
                height: screenHeight * 0.06,
                text: "Login",
                buttonColor: AppTheme.themeRed,
                textColor: AppTheme.whiteBackground,
                fontSize: screenWidth * 0.04,
              )
            ],
          ),
        ),
      ),
    );
  }
}

