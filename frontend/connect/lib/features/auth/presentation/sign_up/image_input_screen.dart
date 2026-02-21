import 'dart:io';

import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:connect/shared/providers/upload_image_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ImageInputScreen extends ConsumerStatefulWidget {
  const ImageInputScreen({super.key});

  @override
  ConsumerState<ImageInputScreen> createState() => _ImageInputScreenState();
}

class _ImageInputScreenState extends ConsumerState<ImageInputScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> images = [];

  Future<void> pickImageFromGallery() async {
    try {
      final picked = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (picked == null) return;
      setState(() {
        if (images.length < 6) {
          images.add(picked);
        }
      });
    } catch (e) {
      print("Failed to pick image from gallery and error is: $e");
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final picked = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (picked == null) return;
      setState(() {
        if (images.length < 6) {
          images.add(picked);
        }
      });
    } catch (e) {
      print("Failed to pick image from camera and error is: $e");
    }
  }

  void removeImage(int index) => setState(() {
    images.removeAt(index);
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final imageCtrl = ref.read(uploadImageControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppTheme.whiteBackground,
      appBar: AppBar(
        title: const Text("Images"),
        backgroundColor: AppTheme.whiteBackground,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          builder: (_) {
                            return SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 12),

                                  Container(
                                    width: 40,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  _bigTapOption(
                                    icon: Icons.photo_library,
                                    text: "Open Gallery",
                                    onTap: () {
                                      context.pop();
                                      pickImageFromGallery();
                                    },
                                  ),

                                  _bigTapOption(
                                    icon: Icons.camera_alt,
                                    text: "Take Photo",
                                    onTap: () {
                                      context.pop();
                                      pickImageFromCamera();
                                    },
                                  ),

                                  const SizedBox(height: 16),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: imageInputCard(
                        index < images.length ? images[index] : null,
                        index,
                      ),
                    ),
                  );
                },
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: AppButton(
                width: screenWidth * 0.95,
                height: screenHeight * 0.06,
                text: "Upload",
                buttonColor: AppTheme.themeRed,
                textColor: AppTheme.whiteBackground,
                fontSize: screenWidth * 0.04,
                onPress: () {
                  if (images.length < 2) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Minimum 2 pictures are required"),
                      ),
                    );
                    return;
                  }

                  final files = images.map((e) => File(e.path)).toList();

                  imageCtrl.uploadPictures(files);

                  // context.pushReplacement("/question");
                },
              ),
            ),

            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }

  Widget imageInputCard(XFile? image, int index) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.greyColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: image == null
          ? Icon(Icons.add, size: 32)
          : ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(image.path),
                    fit: BoxFit.cover,
                    frameBuilder: (context, child, frame, _) {
                      if (frame == null) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.textThemeRed,
                          ),
                        );
                      }

                      return child;
                    },
                  ),
                  Positioned(
                    left: 80,
                    child: IconButton(
                      icon: Icon(Icons.cancel),
                      color: AppTheme.greyColor,
                      onPressed: () {
                        removeImage(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _bigTapOption({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 18),
            Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
