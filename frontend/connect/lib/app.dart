import 'package:connect/core/routing/router.dart';
import 'package:connect/core/widgets/loader/loader.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Loader(),
      ),
    );
    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData.light(),
    //   routerConfig: router,
    // );
  }
}

