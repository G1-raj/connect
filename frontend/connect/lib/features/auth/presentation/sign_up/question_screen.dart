import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

  final List<bool> answers = List.generate(5, (_) => false);


  int currentPage = 0;

  late PageController _pagesController;


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pagesController,
                itemCount: _pages.length,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _pages[index];
                },
              ),
            ),

            VisualStepIndicator(
              steps: 5,
              stepsCompleted: 3,
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02,)
          ],
        ),
      ),
    );
  }
}

class VisualStepIndicator extends StatefulWidget {
  final int steps;
  final int stepsCompleted;
  const VisualStepIndicator(
    {
      super.key, 
      required this.steps,
      required this.stepsCompleted
    }
  );

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
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: widget.stepsCompleted > index ? AppTheme.themeRed : AppTheme.greyColor,
              shape: BoxShape.circle
            ),
          ),
        );
      }),
    );
  }
}

class Question extends StatefulWidget {
  final AssetImage questionImage;
  final TextEditingController controller;
  const Question(
    {
      super.key,
      required this.questionImage,
      required this.controller
    }
  );

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
         SizedBox(
          width: screenWidth,
          height: screenHeight * 0.45,
          child: Image(
            image: widget.questionImage,
          ),
        ),


        Text("Help us personalize your matches"),

        SizedBox(
          height: screenHeight * 0.06,
        ),
      ],
    );
  }
}

