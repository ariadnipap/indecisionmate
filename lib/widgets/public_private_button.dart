import 'package:flutter/material.dart';
import '/text/app_text_themes.dart';

//exei thema ginetai filled aspro anti gia aspro frame
class PublicPrivateButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  final bool isPublicSelected;
  final bool isPrivateSelected;

  PublicPrivateButton({
    required this.text,
    required this.color,
    required this.onTap,
    required this.isPublicSelected,
    required this.isPrivateSelected,
  });

  @override
  _PublicPrivateButtonState createState() => _PublicPrivateButtonState();
}
class _PublicPrivateButtonState extends State<PublicPrivateButton> {
  @override
  Widget build(BuildContext context) {
    bool isSelected =
        widget.text == 'Public' ? widget.isPublicSelected : widget.isPrivateSelected;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          widget.onTap();
        }
      },
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : widget.color,
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: Colors.white, width: 2.0)
              : Border.all(color: Colors.transparent, width: 2.0),
        ),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: AppTextTheme.fallback().suggestions?.copyWith(color: Colors.black) ??
                TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
