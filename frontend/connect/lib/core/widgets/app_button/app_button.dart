import 'package:connect/core/theme/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final double fontSize;
  bool? isButtonTransparent;
  final VoidCallback? onPress;
  AppButton(
    {
      super.key,
      required this.height,
      required this.width,
      required this.text,
      required this.buttonColor,
      required this.textColor,
      required this.fontSize,
      this.onPress,
      this.isButtonTransparent = false
    }
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPress, 
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(0),
            side: BorderSide(width: 1, color: isButtonTransparent! ? AppTheme.whiteBackground : buttonColor)
          )
        ).copyWith(
          backgroundColor: WidgetStatePropertyAll(buttonColor),
          elevation: WidgetStatePropertyAll(4),
        ),
        child: Text(text, style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: fontSize
        ),)
      ),
    );
  }
}