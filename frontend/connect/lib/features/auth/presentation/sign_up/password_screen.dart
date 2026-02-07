import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:connect/core/widgets/input_field/input_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PasswordScreen extends StatelessWidget {
  PasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cnfPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

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
                ),
          
                Spacer(),
          
                 AppButton(
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.06,
                  text: "Create Password",
                  buttonColor: AppTheme.themeRed,
                  textColor: AppTheme.whiteBackground,
                  fontSize: screenWidth * 0.04,
                  onPress: () {
                    context.push("/profile");
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