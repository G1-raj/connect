import 'package:connect/features/auth/providers/auth_repository_provider.dart';
import 'package:connect/shared/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class VerifyOtpState {
  final bool loading;
  final String? error;
  final bool success;

  const VerifyOtpState({
    this.loading = false,
    this.error,
    this.success = false,
  });

  VerifyOtpState copyWith({bool? loading, String? error, bool? success}) {
    return VerifyOtpState(
      loading: loading ?? this.loading,
      error: error,
      success: success ?? this.success,
    );
  }
}

class VerifyOtpController extends StateNotifier<VerifyOtpState> {
  final Ref ref;

  VerifyOtpController(this.ref) : super(VerifyOtpState());

  Future<void> verifyOtp(String email, String otp) async {
    state = state.copyWith(loading: true, error: null, success: false);

    try {
      final repo = ref.read(authRepositoryProvider);
      final storage = ref.read(storageProvider);
      final res = await repo.verifyOtp(email, otp);

      if (res.message!.isNotEmpty) {
        await storage.write(
          key: "onboarding_token",
          value: res.onboardingToken,
        );
        state = state.copyWith(loading: false, error: null, success: true);

        return;
      }

      state = state.copyWith(
        loading: false,
        error: "Failed to verify the otp",
        success: false,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: "Failed to verify the otp",
        success: false,
      );
    }
  }
}
