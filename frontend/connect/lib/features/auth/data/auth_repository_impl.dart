import 'package:connect/features/auth/data/models/login/login_request.dart';
import 'package:connect/features/auth/data/models/login/login_response.dart';
import 'package:connect/features/auth/data/models/signup/request/create_profile_request.dart';
import 'package:connect/features/auth/data/models/signup/request/otp_request.dart';
import 'package:connect/features/auth/data/models/signup/request/password_request.dart';
import 'package:connect/features/auth/data/models/signup/request/signup_request.dart';
import 'package:connect/features/auth/data/models/signup/response/message_response.dart';
import 'package:connect/features/auth/data/models/signup/response/otp_response.dart';
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

  @override
  Future<MessageResponse> signup(String email, String fullName) async {
    final res = await api.signup(
      SignupRequest(email: email, fullName: fullName)
    );

    return res;
  }

  @override
  Future<OtpResponse> verifyOtp(String email, String otp) async {
    final res = await api.verifyOtp(
      OtpRequest(email: email, otp: otp)
    );

    return res;
  }

  @override
  Future<MessageResponse> createPassword(String password, String onboardingToken) async {
    final res = await api.createPassword(
      PasswordRequest(password: password),
      onboardingToken
    );

    return res;
  }

  @override
  Future<MessageResponse> createProfile(
    String gender, 
    String description, 
    String sexuality, 
    DateTime dateOfBirth, 
    double longitude, 
    double latitude, 
    List<String> interests
  ) async  {
    final res = await api.createProfile(
      CreateProfileRequest(
        gender: gender, 
        description: description, 
        sexuality: sexuality, 
        dateOfBirth: dateOfBirth, 
        longitude: longitude, 
        latitude: latitude, 
        interests: interests
      )
    );

    return res;
  }
}