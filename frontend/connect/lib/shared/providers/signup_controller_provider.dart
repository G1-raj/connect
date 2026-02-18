import 'package:connect/features/auth/controllers/signup_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupControllerProvider =
    NotifierProvider<SignupController, SignupState>(SignupController.new);
