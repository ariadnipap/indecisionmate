import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart'; 

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;

  ContinueButton({required this.onPressed, this.width = 129, this.height = 47});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: width,
            height: height,
            decoration: ShapeDecoration(
              color: AppColors.logo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Center(
              child: Text(
                'Continue',
                style: AppTextTheme.fallback().basicText
              ),
            ),
          ),
        ),
      ],
    );
  }
}
