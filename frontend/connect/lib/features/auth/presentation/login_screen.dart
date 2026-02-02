import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:connect/core/widgets/input_field/input_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppTheme.whiteBackground,

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
          
                Text("Login", style: TextStyle(
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
                  hintText: "Password", 
                  prefixIcon: Icon(Icons.lock),
                  isPassword: true, 
                  textController: _emailController,
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.07,
                ),

                SizedBox(
                  height: screenHeight * 0.01,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(onPressed: () {}, child: Text("Signup", style: TextStyle(
                      color: AppTheme.themeRed,
                      fontWeight: FontWeight.bold
                    ),))
                  ],
                ),
          
                
          
                Spacer(),
          
                AppButton(
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.06,
                  text: "Login",
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
      ),
    );
  }
}

