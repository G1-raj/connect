import 'package:connect/features/auth/data/models/login/login_request.dart';
import 'package:connect/features/auth/data/models/login/login_response.dart';
import 'package:connect/features/auth/data/services/auth_api_service.dart';
import 'package:connect/features/auth/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService api;

  AuthRepositoryImpl(this.api);

  @override
  Future<LoginResponse> login(String email, String password) async {
    final res = await api.login(
      LoginRequest(email: email, password: password)
    );

    return res;
  }
}