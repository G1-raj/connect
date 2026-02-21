import 'package:connect/features/auth/controllers/questions_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final answerRepositoryProvider =
    NotifierProvider<QuestionsController, QuestionState>(
      QuestionsController.new,
    );
