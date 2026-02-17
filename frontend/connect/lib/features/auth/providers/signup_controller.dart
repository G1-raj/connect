import 'dart:convert';

import 'package:connect/features/auth/providers/auth_repository_provider.dart';
import 'package:connect/shared/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class SignupState {
  final bool loading;
  final String? error;
  final bool success;

  const SignupState({
    this.loading = false,
    this.error,
    this.success = false
  });

  SignupState copyWith({bool? loading, String? error, bool? success}) {
    return SignupState(
      loading: loading ?? this.loading,
      error: error,
      success: success ?? this.success
    );
  }
}

class SignupController extends StateNotifier<SignupState> {
  final Ref ref;
  
  SignupController(this.ref) : super(const SignupState());

  Future<bool> signup(String email, String fullName) async {

    state = state.copyWith(loading: true, error: null);

    try {

      final repo = ref.read(authRepositoryProvider);
      final res = await repo.signup(email, fullName);

      if(res.message!.isNotEmpty) {
        state = state.copyWith(
          loading: false,
          error: null,
          success: true
        );
      }

      return true;
      
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: "Failed to signup",
        success: false
      );
    }

    return false;
  }

  Future<void> verifyOtp(String email, String otp) async {
    state = state.copyWith(loading: true, error: null, success: false);

    try {

      final repo = ref.read(authRepositoryProvider);
      final storage = ref.read(storageProvider);
      final res = await repo.verifyOtp(email, otp);

      if(res.message!.isNotEmpty) {
        await storage.write(key: "onboarding_token", value:res.onboardingToken);
        state = state.copyWith(
          loading: false,
          error: null,
          success: true
        );


        return;
      }

      state = state.copyWith(
        loading: false,
        error: "Failed to verify the otp",
        success: false
      );
      
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: "Failed to verify the otp",
        success: false
      );

    }
  }

  Future<void> createPassword(String password) async {
    state = state.copyWith(loading: true, error:  null, success: false);

    try {

      final repo = ref.read(authRepositoryProvider);
      final storage = ref.read(storageProvider);

      final onboardingToken = await storage.read(key: "onboarding_token");

      if(onboardingToken == null) throw Exception("No onboarding token");

      final res = await repo.createPassword(password, onboardingToken!);

      if(res.message!.isNotEmpty) {
        state = state.copyWith(
          loading: false,
          error: null,
          success: true
        );

        return;
      }

      state = state.copyWith(
        loading: false,
        error: "Failed to create password",
        success: false
      );
      
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: "Failed to create password",
        success: false
      );

    }
  }

  Future<bool> createProfile(
    String gender, 
    String description, 
    String sexuality, 
    DateTime dateOfBirth, 
    double longitude, 
    double latitude, 
    List<String> interests,
    String onboardingToken
  ) async {
    try {

      final repo = ref.read(authRepositoryProvider);
      final storage = ref.read(storageProvider);

      final onboardingToken = await storage.read(key: "onboarding_token");

      final res = await repo.createProfile(gender, description, sexuality, dateOfBirth, longitude, latitude, interests, onboardingToken!);

      if(res.message!.isNotEmpty) {
        state = state.copyWith(
          loading: false,
          error: null
        );

        return true;
      }

      state = state.copyWith(
        loading: false,
        error: "Failed to create profile"
      );

      return false;
      
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: "Failed to verify the otp"
      );

      return false;
    }
  }

}