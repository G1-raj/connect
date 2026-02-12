import 'package:connect/core/theme/theme.dart';
import 'package:flutter/material.dart';

class SelectionCard extends StatefulWidget {
  final String label;
  final AssetImage image;
  final double width;
  final String selected;
  const SelectionCard(
    {
      super.key,
      required this.label,
      required this.image,
      required this.width,
      required this.selected
    }
  );

  @override
  State<SelectionCard> createState() => _SelectionCardState();
}

class _SelectionCardState extends State<SelectionCard> {

  late bool isSelected;

  @override
  void initState() {
   isSelected = widget.selected == widget.label;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding:  EdgeInsets.all(10),
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
              image: widget.image,
              width: widget.width,
            ),
            const SizedBox(height: 8),
            Text(widget.label, style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? AppTheme.whiteBackground : Colors.black,
            ),)
          ],
        ),
      ),
    );
  }
}