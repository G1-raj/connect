import 'package:connect/shared/providers/auth_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class SignupController extends Notifier<SignupState> {
  @override
  SignupState build() {
    return const SignupState();
  }

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
}
