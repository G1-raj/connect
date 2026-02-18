import 'package:connect/shared/providers/auth_repository_provider.dart';
import 'package:connect/shared/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordState {
  final bool loading;
  final String? error;
  final bool success;

  const PasswordState({this.loading = false, this.error, this.success = false});

  PasswordState copyWith({bool? loading, String? error, bool? success}) {
    return PasswordState(
      loading: loading ?? this.loading,
      error: error,
      success: success ?? this.success,
    );
  }
}

class PasswordController extends Notifier<PasswordState> {
  @override
  PasswordState build() {
    return const PasswordState();
  }

  Future<void> createPassword(String password) async {
    state = state.copyWith(loading: true, error: null, success: false);

    try {
      final repo = ref.read(authRepositoryProvider);
      final storage = ref.read(storageProvider);

      final onboardingToken = await storage.read(key: "onboarding_token");

      if (onboardingToken == null) throw Exception("No onboarding token");

      final res = await repo.createPassword(password, onboardingToken);

      if (res.message!.isNotEmpty) {
        state = state.copyWith(loading: false, error: null, success: true);

        return;
      }

      state = state.copyWith(
        loading: false,
        error: "Failed to create password",
        success: false,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: "Failed to create password",
        success: false,
      );
    }
  }
}
