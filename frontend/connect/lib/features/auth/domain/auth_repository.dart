import 'package:connect/features/auth/data/models/login/login_response.dart';

abstract class AuthRepository {
    Future<LoginResponse> login(String email, String password);
}