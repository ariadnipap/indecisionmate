import 'package:flutter/material.dart';
import '/text/app_text_themes.dart';
import '/colors/app_color_themes.dart';

class SlideButton extends StatelessWidget {
  final String text;
  final Widget page; // Change the type to Widget

  const SlideButton({Key? key, required this.text, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        // Check if the user is sliding to the left
        if (details.primaryDelta! < 0) {
          // Navigate to the specified page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
      child: Container(
        width: 360,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.seeThroughText,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: AppTextTheme.fallback().basicText?.copyWith(color: Colors.black) ??
                  TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(width: 16),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
