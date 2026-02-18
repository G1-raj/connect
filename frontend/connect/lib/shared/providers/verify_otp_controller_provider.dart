import 'package:connect/features/auth/controllers/verify_otp_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final verifyOtpControllerProvider =
    NotifierProvider<VerifyOtpController, VerifyOtpState>(
      VerifyOtpController.new,
    );
