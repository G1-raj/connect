import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthNavigationScreen extends StatelessWidget {
  AuthNavigationScreen({super.key});

  final AssetImage _banner = AssetImage("lib/assets/connect_banner.jpg");

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Image(
              image: _banner,
              fit: BoxFit.fitHeight,
            ),
          ),

          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.6)
            ),
          ),

          //Logo
          Positioned(
            left: screenWidth * 0.3,
            top: screenHeight * 0.1,
            child: Container(
              width: screenWidth * 0.4,
              height: screenWidth * 0.35,
              decoration: BoxDecoration(
                  color: AppTheme.themeRed,
                  shape: BoxShape.circle
              ),
            ),
          ),

          //Slogan
          Positioned(
            top: screenHeight * 0.5,
            left: screenWidth * 0.02,
            child: sloganSection(screenHeight, screenWidth)
          ),

          Positioned(
            top: screenHeight * 0.75,
            left: screenWidth * 0.02,
            child: buttonSection(screenHeight, screenWidth, context)
          )
        ],
      ),
    );
  }

  Widget buttonSection(double screenHeight, double screenWidth, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         AppButton(
          width: screenWidth * 0.95,
          height: screenHeight * 0.06,
          text: "Login",
          buttonColor: AppTheme.themeRed,
          textColor: AppTheme.whiteBackground,
          fontSize: screenWidth * 0.04,
          onPress: () {
            context.push("/login");
          },
        ),

        SizedBox(
          height: screenHeight * 0.02,
        ),

        AppButton(
          width: screenWidth * 0.95,
          height: screenHeight * 0.06,
          text: "Signup",
          buttonColor: Colors.transparent,
          textColor: AppTheme.whiteBackground,
          fontSize: screenWidth * 0.04,
          isButtonTransparent: true,
          onPress: () {
            context.push("/signup");
          },
        ),
      ],
    );
  }

  Widget sloganSection(double screenHeight, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: screenWidth * 0.07,
              fontWeight: FontWeight.w600,
              height: 1.0
            ),
            children: [
              TextSpan(
                text: "Find your ",
                style: TextStyle(color: AppTheme.whiteBackground),
              ),
              TextSpan(
                text: "Partner",
                style: TextStyle(color: AppTheme.themeRed),
              ),
            ],
          ),
        ),


        Text("Let's find your real life partner and enjoy your good life from now!", style: TextStyle(
          color: AppTheme.whiteBackground,
          fontSize: screenWidth * 0.025
        ),)
      ],
    );
  }
}
