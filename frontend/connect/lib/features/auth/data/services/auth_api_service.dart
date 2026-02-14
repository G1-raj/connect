import 'package:connect/core/network/dio_client.dart';
import 'package:connect/features/auth/data/models/login/login_request.dart';
import 'package:connect/features/auth/data/models/login/login_response.dart';
import 'package:dio/dio.dart';

class AuthApiService {
  final Dio dio = DioClient.dio;

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await dio.post(
      "/auth/login",
      data: request.toJson()
    );

    return LoginResponse.fromJson(response.data);
  }
}