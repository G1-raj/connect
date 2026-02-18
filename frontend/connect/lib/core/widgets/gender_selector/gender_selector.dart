import 'package:connect/core/widgets/selection_card/selection_card.dart';
import 'package:flutter/material.dart';

class GenderSelector extends StatefulWidget {
  final TextEditingController genderController;
  const GenderSelector({super.key, required this.genderController});

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
        Text(
          "Select your gender",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: screenWidth * 0.05,
          ),
        ),

        SizedBox(height: screenHeight * 0.02),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SelectionCard(
              label: "male",
              image: _maleImage,
              width: screenWidth * 0.15,
              selected: selected,
              onPress: () {
                select("male");
              },
            ),

            SelectionCard(
              label: "female",
              image: _femaleImage,
              width: screenWidth * 0.15,
              selected: selected,
              onPress: () {
                select("female");
              },
            ),
          ],
        ),

        SizedBox(height: screenHeight * 0.02),

        SelectionCard(
          label: "others",
          image: _otherImage,
          width: screenWidth * 0.15,
          selected: selected,
          onPress: () {
            select("others");
          },
        ),
      ],
    );
  }
}
