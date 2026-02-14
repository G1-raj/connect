import 'package:connect/features/auth/providers/login_controller.dart';
import 'package:flutter_riverpod/legacy.dart';

final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});