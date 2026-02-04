import 'package:connect/core/theme/theme.dart';
import 'package:flutter/material.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppTheme.whiteBackground,

      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.04,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.06),
                  child: heading(screenWidth, screenHeight),
                )
              )
        
              
            ],
          ),
        ),
      ),
    );
  }

  Widget heading(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("What's your", style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: screenWidth * 0.04,
          height: 0.9
        ),),
        Text("Gender", style: TextStyle(
          fontWeight: FontWeight.w800, 
          fontSize: screenWidth * 0.08,
          height: 0.9
        ),)
      ],
    );
  }
}