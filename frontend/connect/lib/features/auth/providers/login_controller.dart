import 'dart:convert';

import 'package:connect/features/auth/providers/auth_repository_provider.dart';
import 'package:connect/shared/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class LoginState {
  final bool loading;
  final String? error;

  const LoginState({
    this.loading = false,
    this.error
  });

  LoginState copyWith({bool? loading, String? error}) {
    return LoginState(
      loading: loading ?? this.loading,
      error: error
    );
  }
}

class LoginController extends StateNotifier<LoginState> {
  final Ref ref;

  LoginController(this.ref) : super(const LoginState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(loading: true, error: null);

    try {

      final repo = ref.read(authRepositoryProvider);
      final _storage = ref.read(storageProvider);
      final res = await repo.login(email, password);

      if(res.data != null && res.token != null) {
        await _storage.write(key: "access_token", value: res.token!.accessToken);
        await _storage.write(key: "refresh_token", value: res.token!.refreshToken);

        await _storage.write(key: "connect_user", value: jsonEncode(res.data));
      }

      

      state = state.copyWith(loading: false);
      
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: "Login failed"
      );
    }
  }
}