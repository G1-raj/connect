import 'package:connect/features/auth/controllers/upload_image_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uploadImageControllerProvider =
    NotifierProvider<UploadImageController, UploadImageState>(
      UploadImageController.new,
    );
