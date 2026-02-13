import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

  final TextEditingController alcoholController = TextEditingController();
  final TextEditingController smokeController = TextEditingController();
  final TextEditingController petsController = TextEditingController();
  final TextEditingController kidsController = TextEditingController();
  final TextEditingController exerciseController = TextEditingController();

  int currentPage = 0;

  late PageController _pagesController;
  List<Widget> get _pages => [
    AlchoholQuestion(textController: alcoholController,),
    SmokeQuestion(textController: smokeController),
    PetsQuestion(textController: petsController),
    KidsQuestion(textController: kidsController),
    ExerciseQuestion(textController: exerciseController)
  ];

  @override
  void initState() {
    _pagesController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    alcoholController.dispose();
    smokeController.dispose();
    petsController.dispose();
    kidsController.dispose();
    exerciseController.dispose();
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
  const VisualStepIndicator(
    {
      super.key, 
      required this.steps
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
      children: List.generate(widget.steps, (_) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppTheme.greyColor,
              shape: BoxShape.circle
            ),
          ),
        );
      }),
    );
  }
}

class AlchoholQuestion extends StatelessWidget {
  final TextEditingController textController;
  const AlchoholQuestion(
    {
      super.key,
      required this.textController
    }
  );

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
            image: AssetImage("lib/assets/alcohol.png"),
          ),
        ),


        Text("Help us personalize your matches"),

        SizedBox(
          height: screenHeight * 0.06,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppButton(
              height: screenHeight * 0.05, 
              width: screenWidth * 0.35, 
              text: "Yes", 
              buttonColor: AppTheme.themeRed, 
              textColor: AppTheme.whiteBackground, 
              fontSize: screenWidth * 0.05,
              borderRadius: 18.0,
            ),

            AppButton(
              height: screenHeight * 0.05, 
              width: screenWidth * 0.35, 
              text: "No", 
              buttonColor: AppTheme.whiteBackground, 
              textColor: AppTheme.themeRed, 
              fontSize: screenWidth * 0.05,
              borderRadius: 18.0,
            ),
          ],
        ),

        SizedBox(
          height: screenHeight * 0.02,
        )
      ],
    );
  }
}

class SmokeQuestion extends StatelessWidget {
  final TextEditingController textController;
  const SmokeQuestion(
    {
      super.key,
      required this.textController
    }
  );

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class PetsQuestion extends StatelessWidget {
  final TextEditingController textController;
  const PetsQuestion(
    {
      super.key,
      required this.textController
    }
  );

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class KidsQuestion extends StatelessWidget {
  final TextEditingController textController;
  const KidsQuestion(
    {
      super.key,
      required this.textController
    }
  );

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class ExerciseQuestion extends StatelessWidget {
  final TextEditingController textController;
  const ExerciseQuestion(
    {
      super.key,
      required this.textController
    }
  );

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}