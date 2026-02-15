import 'dart:convert';

import 'package:connect/features/auth/providers/auth_repository_provider.dart';
import 'package:connect/shared/providers/storage_provider.dart';
import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class SignupState {
  final bool loading;
  final String? error;

  const SignupState({
    this.loading = false,
    this.error
  });

  SignupState copyWith({bool? loading, String? error}) {
    return SignupState(
      loading: loading ?? this.loading,
      error: error
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

      if(res.message!.isEmpty) {
        state = state.copyWith(loading: false, error: null);
      }
      
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: "Failed to signup"
      );
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    state = state.copyWith(loading: true, error: null);

    try {

      final repo = ref.read(authRepositoryProvider);
      final storage = ref.read(storageProvider);
      final res = await repo.verifyOtp(email, otp);

      if(res.message!.isNotEmpty) {
        storage.write(key: "onboarding_token", value: jsonEncode(res.onboardingToken));
      }
      
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: "Failed to verify the otp"
      );
    }
  }
}