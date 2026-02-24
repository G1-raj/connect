import 'package:connect/features/auth/presentation/profile/user_profile_screen.dart';
import 'package:connect/features/auth/presentation/sign_up/image_input_screen.dart';
import 'package:connect/features/auth/presentation/sign_up/profile_screen.dart';
import 'package:connect/features/auth/presentation/sign_up/question_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:connect/features/auth/presentation/sign_up/password_screen.dart';
import 'package:connect/features/auth/presentation/sign_up/signup_screen.dart';
import 'package:connect/features/auth/presentation/sign_up/verify_otp_screen.dart';
import 'package:connect/features/auth/presentation/auth_navigator/auth_navigator.dart';
import 'package:connect/features/auth/presentation/login_screen/login_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: "/auth-navigator",
  routes: [
    GoRoute(
      path: "/auth-navigator",
      builder: (context, state) => AuthNavigationScreen(),
    ),

    GoRoute(path: "/login", builder: (context, state) => LoginScreen()),

    GoRoute(path: "/signup", builder: (context, state) => SignupScreen()),

    GoRoute(
      path: "/verify-otp",
      builder: (context, state) {
        final email = state.extra as String;
        return VerifyOtpScreen(email: email);
      },
    ),

    GoRoute(path: "/password", builder: (context, state) => PasswordScreen()),

    GoRoute(path: "/profile", builder: (context, state) => ProfileScreen()),

    GoRoute(
      path: "/image-input",
      builder: (context, state) => ImageInputScreen(),
    ),

    GoRoute(path: "/question", builder: (context, state) => QuestionScreen()),

    GoRoute(
      path: "/user-profile",
      builder: (context, state) => UserProfileScreen(),
    ),
  ],
);
