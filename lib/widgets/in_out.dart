import 'package:flutter/material.dart';
import '/text/app_text_themes.dart';

class InOutWidget extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback? onPressed; // New line

  const InOutWidget({Key? key, required this.text, required this.color, this.onPressed})
      : super(key: key);

  @override
  _InOutWidgetState createState() => _InOutWidgetState();
}

class _InOutWidgetState extends State<InOutWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onPressed?.call(); // New line
      },
      child: Container(
        width: 142,
        height: 50,
        decoration: BoxDecoration(
          color: widget.color,
          border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: AppTextTheme.fallback().seeThroughText?.copyWith(color: Colors.white) ??
                TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
