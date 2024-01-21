import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';

class EmojiWidget extends StatefulWidget {
  final Image image;
  final VoidCallback? onPressed; // New line

  EmojiWidget({required this.image, this.onPressed}); // Updated line

  @override
  _EmojiWidgetState createState() => _EmojiWidgetState();
}

class _EmojiWidgetState extends State<EmojiWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isSelected = !isSelected);
        widget.onPressed?.call(); // New line
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.logo : AppColors.seeThroughText,
        ),
        child: ClipOval(
          child: Center(
            child: widget.image,
          ),
        ),
      ),
    );
  }
}

