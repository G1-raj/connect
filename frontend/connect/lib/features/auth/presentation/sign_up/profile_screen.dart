import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:connect/core/widgets/date_of_birth/date_of_birth.dart';
import 'package:connect/core/widgets/description/description.dart';
import 'package:connect/core/widgets/gender_selector/gender_selector.dart';
import 'package:connect/core/widgets/interests/interests.dart';
import 'package:connect/core/widgets/sexuality/sexuality.dart';
import 'package:connect/features/auth/providers/signup_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final AssetImage mascott = AssetImage("lib/assets/mascott.png");

  final TextEditingController genderController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController sexualityController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  List<String> interests = [];
  late PageController _pageController;

  int currentPage = 0;

  List<Widget> get pages => [
    GenderSelector(genderController: genderController),
    DateOfBirth(dateOfBirthController: dateOfBirthController),
    Sexuality(sexualityController: sexualityController),
    Description(descriptionController: descriptionController),
    Interests(
      selectedInterests: interests,
      onChanged: (list) {
        interests = list;
      },
    )
  ]; 

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    genderController.dispose();
    descriptionController.dispose();
    sexualityController.dispose();
    dateOfBirthController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();


    _pageController.dispose();

    super.dispose();
  }

  void changePage() {
    if(currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeInOut
      );
    } else {

      if(
        genderController.text.isEmpty || dateOfBirthController.text.isEmpty || sexualityController.text.isEmpty || descriptionController.text.isEmpty
      ) {
        return;
      }
      //first profile data sending function will call
      //sendProfileData();

      //navigate to upload images
      context.pushReplacement("/image-input");
    }
  }

  @override
  Widget build(BuildContext context) {

    final profileState = ref.read(signupControllerProvider);
    final profileCtrl = ref.read(signupControllerProvider.notifier);


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

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              ),

              SizedBox(
                height: screenHeight * 0.02,
              ),

              AppButton(
                width: screenWidth * 0.95,
                height: screenHeight * 0.06,
                text: "Next",
                buttonColor: AppTheme.themeRed,
                textColor: AppTheme.whiteBackground,
                fontSize: screenWidth * 0.04,
                onPress: changePage
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









