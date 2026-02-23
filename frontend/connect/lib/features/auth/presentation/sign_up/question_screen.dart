import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:connect/core/widgets/loader_dialog/loader_dialog.dart';
import 'package:connect/features/auth/controllers/questions_controller.dart';
import 'package:connect/shared/providers/questions_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionScreen extends ConsumerStatefulWidget {
  const QuestionScreen({super.key});

  @override
  ConsumerState<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends ConsumerState<QuestionScreen> {
  final List<bool> answers = List.generate(5, (_) => false);

  int currentPage = 0;
  late PageController _pagesController;
  int stepsCompleted = 0;

  final List<AssetImage> questionImage = [
    AssetImage("lib/assets/alcohol.png"),
    AssetImage("lib/assets/smoke.png"),
    AssetImage("lib/assets/pets.png"),
    AssetImage("lib/assets/kids.png"),
    AssetImage("lib/assets/exercise.png"),
  ];

  @override
  void initState() {
    _pagesController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pagesController.dispose();
    super.dispose();
  }

  void changePage() {
    if (currentPage < questionImage.length - 1) {
      _pagesController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );

      setState(() {
        stepsCompleted++;
      });
    } else {
      print("$answers");
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<QuestionState>(questionsControllerProvider, (prev, next) {
      if (next.loading == true) {
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: AppTheme.loaderBackground,
          builder: (_) => const ImageLoaderDialog(),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppTheme.whiteBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pagesController,
                itemCount: answers.length,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Question(
                    questionImage: questionImage[index],
                    onAnswered: (value) {
                      answers[index] = value;
                      changePage();
                    },
                  );
                },
              ),
            ),

            VisualStepIndicator(steps: 5, stepsCompleted: stepsCompleted),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
        ),
      ),
    );
  }
}

class VisualStepIndicator extends StatefulWidget {
  final int steps;
  final int stepsCompleted;
  const VisualStepIndicator({
    super.key,
    required this.steps,
    required this.stepsCompleted,
  });

  @override
  State<VisualStepIndicator> createState() => _VisualStepIndicatorState();
}

class _VisualStepIndicatorState extends State<VisualStepIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.steps, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            width: 20,
            height: 20,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: widget.stepsCompleted > index
                  ? AppTheme.themeRed
                  : AppTheme.greyColor,
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }
}

class Question extends StatelessWidget {
  final AssetImage questionImage;
  final ValueChanged<bool> onAnswered;
  const Question({
    super.key,
    required this.questionImage,
    required this.onAnswered,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          width: screenWidth,
          height: screenHeight * 0.45,
          child: Image(image: questionImage),
        ),

        Text("Help us personalize your matches"),

        SizedBox(height: screenHeight * 0.06),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppButton(
              width: screenWidth * 0.35,
              height: screenHeight * 0.05,
              borderRadius: 18.0,
              buttonColor: AppTheme.themeRed,
              text: "Yes",
              textColor: AppTheme.whiteBackground,
              fontSize: screenWidth * 0.05,
              onPress: () => onAnswered(true),
            ),

            AppButton(
              width: screenWidth * 0.35,
              height: screenHeight * 0.05,
              borderRadius: 18.0,
              buttonColor: AppTheme.whiteBackground,
              text: "No",
              textColor: AppTheme.themeRed,
              fontSize: screenWidth * 0.05,
              onPress: () => onAnswered(false),
            ),
          ],
        ),
      ],
    );
  }
}
