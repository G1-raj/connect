import 'package:connect/shared/providers/auth_repository_provider.dart';
import 'package:connect/shared/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class QuestionsController extends Notifier<QuestionState> {
  @override
  QuestionState build() {
    return const QuestionState();
  }

  Future<void> answerQuestions(
    bool alcohol,
    bool smoke,
    bool kids,
    bool pets,
    bool exercise,
  ) async {
    state = state.copyWith(loading: true, error: null, success: false);

    try {
      final repo = ref.read(authRepositoryProvider);
      final storage = ref.read(storageProvider);

      final onboardingToken = await storage.read(key: "onboarding_token");

      if (onboardingToken == null) throw Exception("No onboarding token");

      final res = await repo.answerQuestions(
        alcohol,
        smoke,
        kids,
        pets,
        exercise,
        onboardingToken,
      );

      if (res.message!.isNotEmpty) {
        state = state.copyWith(loading: false, error: null, success: true);
        return;
      }

      state = state.copyWith(
        loading: false,
        error: "Failed to answer questions",
        success: false,
      );
    } catch (e) {
      throw Exception("Failed to answer questions");
    }
  }
}
