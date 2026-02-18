import 'package:connect/features/auth/controllers/profile_controller.dart';
import 'package:flutter_riverpod/legacy.dart';

final profileControllerProvider =
    StateNotifierProvider<ProfileController, ProfileState>(
      (ref) => ProfileController(ref),
    );
