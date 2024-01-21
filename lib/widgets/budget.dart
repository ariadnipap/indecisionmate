import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';

class DollarWidget extends StatefulWidget {
  final Image image;
  final VoidCallback? onPressed; // New line

  DollarWidget({required this.image, this.onPressed}); // Updated line

  @override
  _DollarWidgetState createState() => _DollarWidgetState();
}

class _DollarWidgetState extends State<DollarWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isSelected = !isSelected);
        widget.onPressed?.call(); // New line
      },
      child: Container(
        width: 79,
        height: 66,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.logo : AppColors.seeThroughText,
          borderRadius: BorderRadius.circular(33),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(33),
          child: Center(
            child: widget.image,
          ),
        ),
      ),
    );
  }
}
