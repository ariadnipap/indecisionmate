import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';

class ExitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ExitButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      height: 68,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.signUp,
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: onPressed,
              child: Text(
                'Exit',
                style: AppTextTheme.fallback().seeThroughText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
