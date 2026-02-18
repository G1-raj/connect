import 'package:connect/features/auth/providers/verify_otp_controller.dart';
import 'package:flutter_riverpod/legacy.dart';

final verifyOtpControllerProvider =
    StateNotifierProvider<VerifyOtpController, VerifyOtpState>(
      (ref) => VerifyOtpController(ref),
    );
