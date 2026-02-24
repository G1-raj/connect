import 'package:connect/core/theme/theme.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.whiteBackground,

      drawer: Drawer(),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: screenWidth * 0.55,
                    height: screenHeight * 0.025,
                    child: Text("Rebecca more"),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              //profile image section
              Container(
                width: screenWidth * 0.88,
                height: screenHeight * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                ),

                child: SizedBox(),
              ),

              SizedBox(height: screenHeight * 0.02),

              //description box
              SizedBox(
                width: screenWidth * 0.88,
                child: Text("This is description box of user"),
              ),

              //interest section
              SizedBox(width: screenWidth * 0.88, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
