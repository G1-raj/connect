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
          )
        ],
      ),
    );
  }
}
