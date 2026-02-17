import 'package:flutter/material.dart';

class ImageLoaderDialog extends StatefulWidget {
  const ImageLoaderDialog({super.key});

  @override
  State<ImageLoaderDialog> createState() => _ImageLoaderDialogState();
}

class _ImageLoaderDialogState extends State<ImageLoaderDialog>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true); // pulse effect
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: FadeTransition(
        opacity: controller,
        child: ScaleTransition(
          scale: Tween(begin: 0.92, end: 1.05).animate(controller),
          child: Image.asset(
            "lib/assets/loader.png",
            width: 110,
          ),
        ),
      ),
    );
  }
}
