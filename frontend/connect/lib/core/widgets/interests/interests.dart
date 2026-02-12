import 'package:connect/core/widgets/multiple_selection_card/multiple_selection_card.dart';
import 'package:flutter/material.dart';

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
          child: MultipleSelectionCard(
            allInterests: _interests, 
            selectedInterests: widget.selectedInterests,
            onChanged: widget.onChanged,
          )
        )
      ],
    );
  }
}
