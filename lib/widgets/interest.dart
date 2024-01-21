/*import 'package:flutter/material.dart';
import '/text/app_text_themes.dart';

class Interest extends StatefulWidget {
  final String label;
  final Color color;
  final Function(String label) onToggle;

  Interest({required this.label, required this.color, required this.onToggle});

  @override
  _InterestState createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            widget.onToggle(widget.label); // Notify parent about the toggle
          });
        },
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.color,
              border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                widget.label,
                style: AppTextTheme.fallback().basicText?.copyWith(color: Colors.white)
                    ?? TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
} */

import 'package:flutter/material.dart';
import '/text/app_text_themes.dart';

class Interest extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final Function(String label) onToggle;

  Interest({
    required this.label,
    required this.color,
    required this.onToggle,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          onToggle(label);
        },
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color,
              border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                label,
                style: AppTextTheme.fallback().basicText?.copyWith(color: Colors.white)
                    ?? TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
