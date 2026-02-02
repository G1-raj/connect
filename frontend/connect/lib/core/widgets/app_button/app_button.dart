import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final double fontSize;
  final VoidCallback? onPress;
  const AppButton(
    {
      super.key,
      required this.height,
      required this.width,
      required this.text,
      required this.buttonColor,
      required this.textColor,
      required this.fontSize,
      this.onPress
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
            borderRadius: BorderRadiusGeometry.circular(0)
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