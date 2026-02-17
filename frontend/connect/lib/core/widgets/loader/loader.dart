import 'package:connect/core/theme/theme.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      color: AppTheme.loaderBackground,
      child: Image(
        image: AssetImage("lib/assets/loader.png"),
      ),
    );
  }
}