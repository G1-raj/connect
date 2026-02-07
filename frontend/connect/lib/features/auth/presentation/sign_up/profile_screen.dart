import 'package:connect/core/theme/theme.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteBackground,
      
      body: SafeArea(
        child: Center(
          child: Text("Profile screen"),
        ),
      ),
    );
  }
}