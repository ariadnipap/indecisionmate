// suggestion.dart
import 'package:flutter/material.dart';
import '/text/app_text_themes.dart';

class SuggestionCard extends StatefulWidget {
  final String text;
  final Color color;
  final double xPosition;
  final double yPosition;
  final ValueChanged<bool> onSelectionChanged;
  final bool initiallySelected;
  final bool isEvent;
  final Function()? onDoubleTap;
  final Function()? onLongPress;

  const SuggestionCard({
    Key? key,
    required this.text,
    required this.color,
    required this.xPosition,
    required this.yPosition,
    required this.onSelectionChanged,
    this.initiallySelected = false,
    this.isEvent = false,
    this.onDoubleTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  _SuggestionCardState createState() => _SuggestionCardState();
}

class _SuggestionCardState extends State<SuggestionCard> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.initiallySelected;
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = 132;
    double cardHeight = 108.77;

    return Positioned(
      left: widget.xPosition,
      top: widget.yPosition,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            widget.onSelectionChanged(isSelected);
          });
        },
        onDoubleTap: () {
          if (widget.onDoubleTap != null) {
            widget.onDoubleTap!();
          }
        },
        onLongPress: () {
          if (widget.onLongPress != null) {
            widget.onLongPress!();
          }
        },
        child: Container(
          width: cardWidth,
          height: cardHeight,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : widget.color,
            border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: AppTextTheme.fallback().suggestions?.copyWith(color: Colors.black) ??
                  TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
