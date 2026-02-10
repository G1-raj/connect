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
  late PageController _pageController;

  late List<Widget> _pages;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    interestsController.add(TextEditingController());
    _pageController = PageController();

    _pages = [
      GenderSelector(genderController: genderController),
      DateOfBirth(dateOfBirthController: dateOfBirthController)
    ];
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

    for(final i in interestsController) {
      i.dispose();
    }
    super.dispose();
  }

  void changePage() {
    if(currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeInOut
      );
    } else {
      //code of submit profile will go here
    }
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

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  physics: const NeverScrollableScrollPhysics(),
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

class GenderSelector extends StatefulWidget {
  final TextEditingController genderController;
  const GenderSelector(
    {
      super.key,
      required this.genderController
    }
  );

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {

  final AssetImage _maleImage = AssetImage("lib/assets/male_gender.png");
  final AssetImage _femaleImage = AssetImage("lib/assets/female_gender.png");
  final AssetImage _otherImage = AssetImage("lib/assets/other_gender.png");

  String? selected;

  void select(String value) {
    setState(() {
      selected = value;
      widget.genderController.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Text("Select your gender", style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: screenWidth * 0.05
        ),),
        
        SizedBox(
          height: screenHeight * 0.02,
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            genderCard(label: "Male", image: _maleImage, width: screenWidth * 0.15),
            genderCard(label: "Female", image: _femaleImage, width: screenWidth * 0.15),
          ],
        ),
        
        SizedBox(
          height: screenHeight * 0.02,
        ),
        
        genderCard(label: "Other", image: _otherImage, width: screenWidth * 0.15),
      ],
    );
  }

  Widget genderCard({required String label, required AssetImage image, required double width}) {

    final isSelected = selected == label;

    return GestureDetector(
      onTap: () => select(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.themeRed : Colors.grey.shade300,
            width: isSelected ? 3 : 1
          ),
          color: isSelected ? AppTheme.themeRed : Colors.white
        ),
        child: Column(
          children: [
            Image(
              image: image,
              width: width,
            ),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? AppTheme.whiteBackground : Colors.black,
            ),)
          ],
        ),
      ),
    );
  }
}

class DateOfBirth extends StatelessWidget {
  final TextEditingController dateOfBirthController;
  const DateOfBirth(
    {
      super.key,
      required this.dateOfBirthController
    }
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Date of birth selector page"),
    );
  }
}