import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AssetImage mascott = AssetImage("lib/assets/mascott.png");

  final TextEditingController genderController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController sexualityController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final List<TextEditingController> interestsController = [];

  @override
  void dispose() {
    genderController.dispose();
    descriptionController.dispose();
    sexualityController.dispose();
    dateOfBirthController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppTheme.whiteBackground,
      
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.35,
                child: Image(
                  image: mascott,
                ),
              ),

              SizedBox(
                height: screenHeight * 0.04,
              ),

              // Expanded(
              //   child: PageView.builder(),
              // ),

              Spacer(),

              AppButton(
                width: screenWidth * 0.95,
                height: screenHeight * 0.06,
                text: "Next",
                buttonColor: AppTheme.themeRed,
                textColor: AppTheme.whiteBackground,
                fontSize: screenWidth * 0.04,
                onPress: () {
                 
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

class GenderSelector extends StatelessWidget {
  const GenderSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}