import 'package:connect/core/theme/theme.dart';
import 'package:flutter/material.dart';

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