import 'dart:async';

import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:connect/shared/providers/verify_otp_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {
  final String email;
  const VerifyOtpScreen({super.key, required this.email});

  @override
  ConsumerState<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  String checkOtp = "";
  bool isTimeCompleted = false;
  int secondsLeft = 120;
  Timer? timer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    secondsLeft = 120;
    isTimeCompleted = false;

    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsLeft == 0) {
        setState(() {
          isTimeCompleted = true;
        });
        timer.cancel();
      } else {
        setState(() {
          secondsLeft--;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final verifyOtpCtrl = ref.read(verifyOtpControllerProvider.notifier);

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    ref.listen(verifyOtpControllerProvider, (prev, next) {
      if (next.loading == true) {
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: AppTheme.loaderBackground,
          builder: (_) {
            return Center(
              child: Image(image: AssetImage("lib/assets/loader.png")),
            );
          },
        );
      }

      if (prev?.loading == true && next.loading == false && context.mounted) {
        context.pop();
      }

      if (next.success && context.mounted) {
        context.push("/password");
      }

      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(next.error!)),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppTheme.whiteBackground,

      appBar: AppBar(elevation: 0, backgroundColor: AppTheme.whiteBackground),

      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.02),

              _banner(screenWidth, screenHeight, widget.email),

              SizedBox(height: screenHeight * 0.06),

              OtpField(
                onChanged: (otp) {
                  setState(() {
                    checkOtp = otp;
                  });
                },
              ),

              SizedBox(height: screenHeight * 0.04),

              GestureDetector(
                onTap: isTimeCompleted
                    ? () {
                        startTimer();
                      }
                    : null,
                child: resendMailButton(
                  screenWidth,
                  screenHeight,
                  isTimeCompleted,
                  secondsLeft,
                ),
              ),

              Spacer(),

              AppButton(
                width: screenWidth * 0.95,
                height: screenHeight * 0.06,
                text: "Verify",
                buttonColor: AppTheme.themeRed,
                textColor: AppTheme.whiteBackground,
                fontSize: screenWidth * 0.04,
                onPress: () async {
                  if (checkOtp.length < 6) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: const Text("Please provide the valid otp"),
                      ),
                    );
                  } else {
                    await verifyOtpCtrl.verifyOtp(widget.email, checkOtp);
                  }
                },
              ),

              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _banner(double screenWidth, double screenHeight, String email) {
    return Column(
      children: [
        Text(
          "Please enter the code",
          style: TextStyle(
            color: AppTheme.primaryText,
            fontWeight: FontWeight.w700,
            fontSize: screenWidth * 0.08,
          ),
        ),

        SizedBox(
          width: screenWidth * 0.85,
          child: Text(
            "We sent an email to $email",
            textAlign: TextAlign.center,
            style: TextStyle(
              // color: AppColors.darkThemePrimaryColor,
              fontSize: screenWidth * 0.04,
            ),
          ),
        ),

        SizedBox(height: screenHeight * 0.02),

        Icon(Icons.mail, size: 50, color: AppTheme.themeRed),
      ],
    );
  }

  Widget resendMailButton(
    double screenWidth,
    double screenHeight,
    bool isTimeCompleted,
    int secondsLeft,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't get a mail?",
          style: TextStyle(
            color: AppTheme.primaryText,
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(width: screenWidth * 0.01),

        Text(
          isTimeCompleted ? "send again" : "retry in $secondsLeft seconds",
          style: TextStyle(
            color: isTimeCompleted ? AppTheme.themeRed : AppTheme.textThemeRed,
          ),
        ),
      ],
    );
  }
}

class OtpField extends StatefulWidget {
  final Function(String) onChanged;
  const OtpField({super.key, required this.onChanged});

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    final otp = controllers.map((c) => c.text).join();
    widget.onChanged(otp);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: screenWidth * 0.12,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),

            decoration: InputDecoration(
              counterText: "",
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12.0),
              //   borderSide: BorderSide(color: AppTheme.themeRed),
              // ),

              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12.0),
              //   borderSide: BorderSide(color: AppTheme.themeRed),
              // ),
            ),

            onChanged: (value) => _onChanged(index, value),
          ),
        );
      }),
    );
  }
}
