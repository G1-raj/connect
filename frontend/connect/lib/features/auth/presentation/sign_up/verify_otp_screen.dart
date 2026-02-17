import 'dart:async';

import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:connect/features/auth/providers/signup_controller_provider.dart';
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
  int secondsLeft = 600;
  Timer? timer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {

    secondsLeft = 600;
    isTimeCompleted = false;

    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(secondsLeft == 0) {
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

    final verifyOtpState = ref.watch(signupControllerProvider);
    final verifyOtpCtrl = ref.read(signupControllerProvider.notifier);

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    ref.listen(signupControllerProvider, (prev, next) {
      if(next.loading == true) {
        showDialog(
          context: context, 
          builder: (_) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppTheme.textThemeRed,
              ),
            );
          }
        );
      }

      if(prev?.loading == true && next.loading == false) {
        context.pop();
      }


      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(next.error!)
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppTheme.whiteBackground,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05, top: screenHeight * 0.04),
                  child: Text("Verify Otp", style: TextStyle(
                    color: AppTheme.blackBackground,
                    fontWeight: FontWeight.w800,
                    fontSize: screenWidth * 0.06,
                    letterSpacing: 0.5
                  ),),
                ),
              ),

              SizedBox(
                height: screenHeight * 0.06,
              ),

              OtpField(
                onChanged: (otp) {
                  setState(() {
                    checkOtp = otp;
                  });
                  print("OTP is: $otp");
                },
              ),

              SizedBox(
                height: screenHeight * 0.04,
              ),

              TextButton(onPressed: isTimeCompleted ? () {
                print("Resend OTP");
                startTimer();
              } : 
                null, 
                child: Text(
                  isTimeCompleted ? "Resend OTP" : "Retry in $secondsLeft seconds", 
                  style: TextStyle(
                    color: AppTheme.themeRed,
                    fontWeight: FontWeight.w600
              ),)),

              Spacer(),

              AppButton(
                width: screenWidth * 0.95,
                height: screenHeight * 0.06,
                text: "Verify",
                buttonColor: AppTheme.themeRed,
                textColor: AppTheme.whiteBackground,
                fontSize: screenWidth * 0.04,
                onPress: () async {
                  print("OTP is $checkOtp");
                  if(checkOtp.isEmpty) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: const Text("Please provide the otp")
                      )
                    );
                  } else {

                    final isSuccess = await verifyOtpCtrl.verifyOtp(widget.email, checkOtp);

                    if(isSuccess && context.mounted) {
                      context.push("/password");
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: const Text("Failed to verify the otp")
                        )
                      );
                    }
                  }
                },
              ),
        
              SizedBox(
                height: screenHeight * 0.02,
              )
            ],
          ),
        ),
      ),
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

  final List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for(final c in controllers) {
      c.dispose();
    }
    for(final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if(value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    if(value.isEmpty && index > 0) {
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
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),

            decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: AppTheme.themeRed)
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: AppTheme.themeRed)
              ),
            ),

            onChanged: (value) => _onChanged(index, value),
          ),
        );
      })
    );
  }
}