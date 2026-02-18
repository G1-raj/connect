import 'package:connect/features/auth/providers/signup_controller.dart';
import 'package:flutter_riverpod/legacy.dart';

final signupControllerProvider = StateNotifierProvider<SignupController, SignupState>((ref) => SignupController(ref));