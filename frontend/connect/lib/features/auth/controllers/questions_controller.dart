class QuestionState {
  final bool loading;
  final String? error;
  final bool success;

  const QuestionState({this.loading = false, this.error, this.success = false});

  QuestionState copyWith({bool? loading, String? error, bool? success}) {
    return QuestionState(
      loading: loading ?? this.loading,
      error: error,
      success: success ?? this.success,
    );
  }
}
