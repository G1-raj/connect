import 'package:connect/core/theme/theme.dart';
import 'package:connect/core/widgets/app_button/app_button.dart';
import 'package:connect/core/widgets/selection_card/selection_card.dart';
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
      //code of submit profile will go here
      print("User Gender is: ${genderController.text}");
      print("User date of birth is: ${dateOfBirthController.text}");
      print("User sexuality is: ${sexualityController.text}");
      print(("User description is: ${descriptionController.text}"));
      print("User interests are: $interests");
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
            SelectionCard(
              label: "Male", 
              image: _maleImage, 
              width: screenWidth * 0.15, 
              selected: selected,
              onPress: () {
                select("Male");
              }
            ),

            SelectionCard(
              label: "Female", 
              image: _femaleImage, 
              width: screenWidth * 0.15, 
              selected: selected,
              onPress: () {
                select("Female");
              }
            ),
          ],
        ),
        
        SizedBox(
          height: screenHeight * 0.02,
        ),

        SelectionCard(
          label: "Other", 
          image: _otherImage, 
          width: screenWidth * 0.15, 
          selected: selected,
          onPress: () {
            select("Other");
          }
        ),
      ],
    );
  }
}

class DateOfBirth extends StatefulWidget {
  final TextEditingController dateOfBirthController;
  const DateOfBirth(
    {
      super.key,
      required this.dateOfBirthController
    }
  );

  @override
  State<DateOfBirth> createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {

  DateTime? selectedDate;

   Map<int, String> months = {
      1: "January",
      2: "February",
      3: "March",
      4: "April",
      5: "May",
      6: "June",
      7: "July",
      8: "August",
      9: "September",
      10: "October",
      11: "November",
      12: "December"
    };

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context, 
      initialDate: DateTime(2000),
      firstDate: DateTime(1950), 
      lastDate: DateTime.now()
    );

    if(picked != null) {
      setState(() {
        selectedDate = picked;
        widget.dateOfBirthController.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final int? month = selectedDate?.month;
    final day = selectedDate != null ? selectedDate!.day : "__";
    final year = selectedDate != null ? selectedDate!.year : "__";

    final monthName = month != null ? months[month]! : "__";

    return Column(
      children: [
        Text("What's your date of birth", style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: screenWidth * 0.05
        ),),

        SizedBox(
          height: screenHeight * 0.02,
        ),

        GestureDetector(
          onTap: pickDate,
          child: Container(
            width: screenWidth * 0.85,
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
              color: Color.fromRGBO(254, 240, 237, 1),
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(
                color: AppTheme.themeRed,
                width: 1
              )
            ),
          
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    dateGrid(label: "Month", value: monthName, width: screenWidth),
                    dateGrid(label: "Day", value: day.toString(), width: screenWidth),
                    dateGrid(label: "Year", value: year.toString(), width: screenWidth)
                  ],
                ),
          
                Spacer(),
          
                banner(screenWidth, screenHeight)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget dateGrid({required String label, required String value, required double width}) {
    return Column(
      children: [
        Text(label, style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppTheme.themeRed,
          fontSize: width * 0.05,
          letterSpacing: 0.7
        ),),

        SizedBox(
          height: 8
        ),

        Container(
          width: width * 0.2,
          height: 80,
          decoration: BoxDecoration(
            color: AppTheme.whiteBackground,
            borderRadius: BorderRadius.circular(18.0)
          ),
          child: Center(child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: width * 0.05
            ),
          )),
        )
      ],
    );
  }

  Widget banner(double width, double height) {
    return Container(
      width: width,
      height: height * 0.08,
      decoration: BoxDecoration(
        color: Color.fromRGBO(253, 221, 222, 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18.0), 
          bottomRight: Radius.circular(18.0)
        ),
        border: Border.all(
          color: Color.fromRGBO(254, 240, 237, 1),
          width: 1
        )
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_month, color: AppTheme.themeRed, size: 38,),
          Text("Date of Birth", style: TextStyle(
            color: AppTheme.themeRed,
            fontWeight: FontWeight.w700,
            fontSize: width * 0.04
          ),)
        ],
      ),
    );
  }
}

class Sexuality extends StatefulWidget {
  final TextEditingController sexualityController;
  const Sexuality(
    {
      super.key,
      required this.sexualityController
    }
  );

  @override
  State<Sexuality> createState() => _SexualityState();
}

class _SexualityState extends State<Sexuality> {

  final AssetImage _straight = AssetImage("lib/assets/straight.png");
  final AssetImage _gay = AssetImage("lib/assets/gay.png");
  final AssetImage _lesbian = AssetImage("lib/assets/lesbian.png");
  final AssetImage _asexual = AssetImage("lib/assets/asexual.png");

  String? selected;

  void select(String value) {
    setState(() {
      selected = value;
      widget.sexualityController.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Text("What's your sexuality", style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: screenWidth * 0.05
        ),),
        
        SizedBox(
          height: screenHeight * 0.02,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SelectionCard(
              label: "Straight", 
              image: _straight, 
              width: screenWidth * 0.18, 
              selected: selected,
              isSexuality: true,
              onPress: () {
                select("Straight");
              }
            ),

            SelectionCard(
              label: "Gay", 
              image: _gay, 
              width: screenWidth * 0.18, 
              selected: selected,
              isSexuality: true,
              onPress: () {
                select("Gay");
              }
            ),
          ],
        ),

        SizedBox(
          height: screenHeight * 0.02,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SelectionCard(
              label: "Lesbian", 
              image: _lesbian, 
              width: screenWidth * 0.18, 
              selected: selected,
              isSexuality: true,
              onPress: () {
                select("Lesbian");
              }
            ),

            SelectionCard(
              label: "Asexual", 
              image: _asexual, 
              width: screenWidth * 0.18, 
              selected: selected,
              isSexuality: true,
              onPress: () {
                select("Asexual");
              }
            ),
          ],
        )
      ],
    );
  }
}

class Description extends StatelessWidget {
  final TextEditingController descriptionController;
  const Description(
    {
      super.key,
      required this.descriptionController
    }
  );

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
         Text("Write something about yourself", style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: screenWidth * 0.05
        ),),
        
        SizedBox(
          height: screenHeight * 0.02,
        ),

        SizedBox(
          width: screenWidth * 0.85,
          height: screenHeight * 0.34,
          child: TextField(
            maxLines: null,
            expands: true,
            controller: descriptionController,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hint: const Text("Your short introduction"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0)
              )
            ),
          )
        )
      ],
    );
  }
}

class Interests extends StatefulWidget {
  final List<String> selectedInterests;
  final ValueChanged<List<String>> onChanged;
  const Interests(
    {
      super.key,
      required this.selectedInterests,
      required this.onChanged
    }
  );

  @override
  State<Interests> createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {

  final List<String> _interests = [
    // Entertainment
    "Movies",
    "Music",
    "TV Shows",
    "Anime",
    "Gaming",
    "Podcasts",
    "Stand-up Comedy",

    // Lifestyle
    "Travel",
    "Fitness",
    "Yoga",
    "Gym",
    "Running",
    "Cycling",
    "Meditation",

    // Food & Drink
    "Food",
    "Cooking",
    "Baking",
    "Coffee",
    "Tea",
    "Street Food",
    "Fine Dining",

    // Social & Fun
    "Parties",
    "Clubbing",
    "Dancing",
    "Karaoke",
    "Board Games",

    // Creative
    "Reading",
    "Writing",
    "Photography",
    "Painting",
    "Drawing",
    "Design",

    // Tech & Learning
    "Technology",
    "Programming",
    "AI",
    "Startups",
    "Finance",
    "Investing",

    // Outdoors
    "Hiking",
    "Camping",
    "Trekking",
    "Nature",
    "Beach",
    "Mountains",

    // Animals
    "Pets",
    "Dogs",
    "Cats",

    // Sports
    "Cricket",
    "Football",
    "Basketball",
    "Badminton",
    "Swimming",

    // Culture
    "Fashion",
    "Shopping",
    "Spirituality",
    "Volunteering"
  ];


  void select(String value) {
    setState(() {
      if(widget.selectedInterests.contains(value)) {
        widget.selectedInterests.remove(value);
      } else {
        widget.selectedInterests.add(value);
      }
    });

    widget.onChanged(widget.selectedInterests);
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Text("What are your interests", style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: screenWidth * 0.05
        ),),
        
        SizedBox(
          height: screenHeight * 0.02,
        ),

        Expanded(
          child: multipleSelectionCard(allInterests: _interests)
        )
      ],
    );
  }

  Widget multipleSelectionCard({required List<String> allInterests}) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: allInterests.map((interest) {
          final isSelected = widget.selectedInterests.contains(interest);
          return GestureDetector(
            onTap: () {
              select(interest);
            },
            child: Chip(
              backgroundColor: isSelected ? AppTheme.themeRed : AppTheme.whiteBackground,
              label: Text(
                interest,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                  color: isSelected ? AppTheme.whiteBackground : AppTheme.blackBackground
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
