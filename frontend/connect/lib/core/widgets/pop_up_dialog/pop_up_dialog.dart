import 'package:connect/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopUpDialog extends StatelessWidget {
  final String email;
  final VoidCallback onConfirm;
  final String title;
  final String body;
  const PopUpDialog(
    {
      super.key,
      required this.email,
      required this.onConfirm,
      required this.title,
      required this.body
    }
  );

  @override
  Widget build(BuildContext context) {


    return AlertDialog(
      backgroundColor: AppTheme.whiteBackground,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)
      ),
      title: Text(title),
      content: Text("$body $email"),

      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text("Change Email"),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.themeRed,
          ),
          onPressed: () {
            context.pop();
            onConfirm();
          },
          child: Text("Confirm", style: TextStyle(
            color: AppTheme.whiteBackground
          ),),
        ),
      ],
    );
  }
}