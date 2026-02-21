import 'dart:io';

import 'package:connect/features/auth/data/models/login/login_response.dart';
import 'package:connect/features/auth/data/models/signup/response/message_response.dart';
import 'package:connect/features/auth/data/models/signup/response/otp_response.dart';

abstract class AuthRepository {
  //login
  Future<LoginResponse> login(String email, String password);

  //signup
  Future<MessageResponse> signup(String email, String fullName);
  Future<OtpResponse> verifyOtp(String email, String otp);
  Future<MessageResponse> createPassword(
    String password,
    String onboardingToken,
  );
  Future<MessageResponse> createProfile(
    String gender,
    String description,
    String sexuality,
    DateTime dateOfBirth,
    double longitude,
    double latitude,
    List<String> interests,
    String onboardingToken,
  );
  Future<MessageResponse> uploadPictures(
    List<File> images,
    String onboardingToken,
  );
  Future<MessageResponse> answerQuestions(
    bool alcohol,
    bool smoke,
    bool kids,
    bool pets,
    bool exercise,
    String onboardingToken,
  );
}
