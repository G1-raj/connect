class UploadImageState {
  final bool loading;
  final String? error;
  final bool success;

  UploadImageState({this.loading = false, this.error, this.success = false});

  UploadImageState copyWith({bool? loading, String? error, bool? success}) {
    return UploadImageState(
      loading: loading ?? this.loading,
      error: error,
      success: success ?? this.success,
    );
  }
}

class UploadImageController {}
