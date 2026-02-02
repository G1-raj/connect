import 'package:go_router/go_router.dart';
import 'package:connect/features/auth/presentation/auth_navigator/auth_navigator.dart';
import 'package:connect/features/auth/presentation/login_screen/login_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: "/auth-navigator",
  routes: [
    GoRoute(
      path: "/auth-navigator",
      builder: (context, state) => AuthNavigationScreen(),
    ),

    GoRoute(
      path: "/login",
      builder: (context, state) => LoginScreen()
    )
  ]
);