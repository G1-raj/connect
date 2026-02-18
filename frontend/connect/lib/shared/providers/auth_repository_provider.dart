import 'package:connect/features/auth/data/auth_repository_impl.dart';
import 'package:connect/features/auth/data/services/auth_api_service.dart';
import 'package:connect/features/auth/domain/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = AuthApiService();
  return AuthRepositoryImpl(api);
});