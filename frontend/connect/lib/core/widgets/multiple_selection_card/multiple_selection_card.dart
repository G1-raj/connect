import 'package:connect/core/theme/theme.dart';
import 'package:flutter/material.dart';

class MultipleSelectionCard extends StatefulWidget {
  final List<String> allInterests;
  final List<String> selectedInterests;
  final ValueChanged<List<String>> onChanged;
  const MultipleSelectionCard(
    {
      super.key,
      required this.allInterests,
      required this.selectedInterests,
      required this.onChanged
    }
  );

  @override
  State<MultipleSelectionCard> createState() => _MultipleSelectionCardState();
}

class _MultipleSelectionCardState extends State<MultipleSelectionCard> {

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
    return SingleChildScrollView(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: widget.allInterests.map((interest) {

          final isSelected = widget.selectedInterests.contains(interest);

          return GestureDetector(
            onTap: () {
              select(interest);
            },
            child: Chip(
              backgroundColor: isSelected ? AppTheme.themeRed : AppTheme.whiteBackground,
              label: 
              Text(
                interest,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                  color: isSelected ? AppTheme.whiteBackground : AppTheme.blackBackground
                ),
              )
            )
          );
        }).toList(),
      ),
    );
  }
}