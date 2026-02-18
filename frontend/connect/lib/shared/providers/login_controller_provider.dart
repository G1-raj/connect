import 'package:connect/features/auth/controllers/login_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(
  LoginController.new,
);
