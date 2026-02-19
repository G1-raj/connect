import 'dart:io';

import 'package:connect/shared/providers/auth_repository_provider.dart';
import 'package:connect/shared/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadImageState {
  final bool loading;
  final String? error;
  final bool success;

  const UploadImageState({
    this.loading = false,
    this.error,
    this.success = false,
  });

  UploadImageState copyWith({bool? loading, String? error, bool? success}) {
    return UploadImageState(
      loading: loading ?? this.loading,
      error: error,
      success: success ?? this.success,
    );
  }
}

class UploadImageController extends Notifier<UploadImageState> {
  @override
  UploadImageState build() {
    return const UploadImageState();
  }

  Future<void> uploadPictures(List<File> images) async {
    state = state.copyWith(loading: true, error: null, success: false);

    try {
      final res = ref.read(authRepositoryProvider);
      final storage = ref.read(storageProvider);

      final onboardingToken = await storage.read(key: "onboarding_token");

      if (onboardingToken == null) throw Exception("Onboarding token missing");

      final response = await res.uploadPictures(images, onboardingToken);

      if (response.message!.isNotEmpty) {
        state = state.copyWith(loading: false, error: null, success: true);
        return;
      }

      state = state.copyWith(
        loading: false,
        error: "Failed to upload pictures",
        success: false,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: "Failed to upload pictures",
        success: false,
      );
    }
  }
}
