import 'package:flutter/material.dart';

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