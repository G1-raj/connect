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

      body: SingleChildScrollView(
        child: SafeArea(child: Column(children: [
              
            ],
          )),
      ),
    );
  }
}
