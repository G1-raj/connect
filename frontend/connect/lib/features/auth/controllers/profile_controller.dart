import 'package:connect/shared/providers/auth_repository_provider.dart';
import 'package:connect/shared/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileState {
  final bool loading;
  final String? error;
  final bool success;

  const ProfileState({this.loading = false, this.error, this.success = false});

  ProfileState copyWith({bool? loading, String? error, bool? success}) {
    return ProfileState(
      loading: loading ?? this.loading,
      error: error,
      success: success ?? this.success,
    );
  }
}

class ProfileController extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    return const ProfileState();
  }

  Future<void> createProfile(
    String gender,
    String description,
    String sexuality,
    DateTime dateOfBirth,
    double longitude,
    double latitude,
    List<String> interests,
  ) async {
    state = state.copyWith(loading: true, error: null, success: false);

    try {
      final repo = ref.read(authRepositoryProvider);
      final storage = ref.read(storageProvider);

      final onboardingToken = await storage.read(key: "onboarding_token");

      if (onboardingToken == null) throw Exception("No onboarding token");

      final res = await repo.createProfile(
        gender,
        description,
        sexuality,
        dateOfBirth,
        longitude,
        latitude,
        interests,
        onboardingToken,
      );

      if (res.message!.isNotEmpty) {
        state = state.copyWith(loading: false, error: null, success: true);

        return;
      }

      state = state.copyWith(loading: false, error: "Failed to create profile");
    } catch (e) {
      state = state.copyWith(loading: false, error: "Failed to create profile");
    }
  }
}
