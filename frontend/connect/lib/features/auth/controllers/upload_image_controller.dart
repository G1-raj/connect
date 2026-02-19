import 'dart:io';

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

    try {} catch (e) {
      state = state.copyWith(
        loading: false,
        error: "Failed to upload pictures",
        success: false,
      );
    }
  }
}
