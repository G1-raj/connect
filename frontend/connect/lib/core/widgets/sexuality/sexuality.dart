import 'package:connect/core/widgets/selection_card/selection_card.dart';
import 'package:flutter/material.dart';

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