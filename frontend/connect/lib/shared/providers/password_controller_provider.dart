import 'package:connect/features/auth/controllers/password_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordControllerProvider =
    NotifierProvider<PasswordController, PasswordState>(PasswordController.new);
