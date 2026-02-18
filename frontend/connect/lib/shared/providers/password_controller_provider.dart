import 'package:connect/features/auth/providers/password_controller.dart';
import 'package:flutter_riverpod/legacy.dart';

final passwordControllerProvider =
    StateNotifierProvider<PasswordController, PasswordState>(
      (ref) => PasswordController(ref),
    );
