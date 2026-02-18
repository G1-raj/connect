import 'package:connect/features/auth/providers/auth_repository_provider.dart';
import 'package:connect/shared/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class SignupState {
  final bool loading;
  final String? error;
  final bool success;

  const SignupState({this.loading = false, this.error, this.success = false});

  SignupState copyWith({bool? loading, String? error, bool? success}) {
    return SignupState(
      loading: loading ?? this.loading,
      error: error,
      success: success ?? this.success,
    );
  }
}

class SignupController extends StateNotifier<SignupState> {
  final Ref ref;

  SignupController(this.ref) : super(const SignupState());

  Future<void> signup(String email, String fullName) async {
    state = state.copyWith(loading: true, error: null);

    try {
      final repo = ref.read(authRepositoryProvider);
      final res = await repo.signup(email, fullName);

      if (res.message!.isNotEmpty) {
        state = state.copyWith(loading: false, error: null, success: true);

        return;
      }

      state = state.copyWith(
        loading: false,
        success: false,
        error: "Failed to signup",
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: "Failed to signup",
        success: false,
      );
    }
  }

  Future<void> createProfile(
    String gender,
    String description,
    String sexuality,
    DateTime dateOfBirth,
    double longitude,
    double latitude,
    List<String> interests,
    String onboardingToken,
  ) async {
    state = state.copyWith(loading: true, error: null, success: false);

    try {
      final repo = ref.read(authRepositoryProvider);
      final storage = ref.read(storageProvider);

      final onboardingToken = await storage.read(key: "onboarding_token");

      final res = await repo.createProfile(
        gender,
        description,
        sexuality,
        dateOfBirth,
        longitude,
        latitude,
        interests,
        onboardingToken!,
      );

      if (res.message!.isNotEmpty) {
        state = state.copyWith(loading: false, error: null, success: true);

        return;
      }

      state = state.copyWith(loading: false, error: "Failed to create profile");
    } catch (e) {
      state = state.copyWith(loading: false, error: "Failed to verify the otp");
    }
  }
}
