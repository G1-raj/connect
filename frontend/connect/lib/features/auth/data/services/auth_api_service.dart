import 'package:connect/core/network/dio_client.dart';
import 'package:connect/features/auth/data/models/login/login_request.dart';
import 'package:connect/features/auth/data/models/login/login_response.dart';
import 'package:connect/features/auth/data/models/signup/request/create_profile_request.dart';
import 'package:connect/features/auth/data/models/signup/request/otp_request.dart';
import 'package:connect/features/auth/data/models/signup/request/password_request.dart';
import 'package:connect/features/auth/data/models/signup/request/signup_request.dart';
import 'package:connect/features/auth/data/models/signup/response/message_response.dart';
import 'package:connect/features/auth/data/models/signup/response/otp_response.dart';
import 'package:dio/dio.dart';

class AuthApiService {
  final Dio dio = DioClient.dio;

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await dio.post("/auth/login", data: request.toJson());

    return LoginResponse.fromJson(response.data);
  }

  Future<MessageResponse> signup(SignupRequest request) async {
    final response = await dio.post("/auth/signup", data: request.toJson());

    return MessageResponse.fromJson(response.data);
  }

  Future<OtpResponse> verifyOtp(OtpRequest request) async {
    final response = await dio.post("/auth/verify-otp", data: request.toJson());

    return OtpResponse.fromJson(response.data);
  }

  Future<MessageResponse> createPassword(
    PasswordRequest request,
    String onboardingToken,
  ) async {
    final response = await dio.post(
      "/auth/create-password",
      data: request.toJson(),
      options: Options(headers: {"Authorization": "Bearer $onboardingToken"}),
    );

    return MessageResponse.fromJson(response.data);
  }

  Future<MessageResponse> createProfile(
    CreateProfileRequest request,
    String onboardingToken,
  ) async {
    final response = await dio.post(
      "/auth/create-profile",
      data: request.toJson(),
      options: Options(headers: {"Authorizarion": "Bearer $onboardingToken"}),
    );

    return MessageResponse.fromJson(response.data);
  }
}
