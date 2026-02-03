import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05, top: screenHeight * 0.04),
                  child: Text("Verify Otp", style: TextStyle(
                    color: AppTheme.blackBackground,
                    fontWeight: FontWeight.w800,
                    fontSize: screenWidth * 0.06,
                    letterSpacing: 0.5
                  ),),
                ),
              ),

              Spacer(),

              AppButton(
                width: screenWidth * 0.95,
                height: screenHeight * 0.06,
                text: "Verify",
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
    );
  }
}

class OtpField extends StatefulWidget {
  const OtpField({super.key});

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}