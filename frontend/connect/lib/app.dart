import 'package:connect/core/theme/theme.dart';
import 'package:connect/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: AuthNavigationScreen(),
    );
  }
}

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
          )
        ],
      ),
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
