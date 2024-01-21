import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';
class WheelButton extends StatelessWidget {
  final VoidCallback? onPressed;

  WheelButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 235,
      height: 40,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 235,
              height: 40,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [AppColors.pink, AppColors.yellow],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 4,
            child: GestureDetector(
              onTap: onPressed,
              child: SizedBox(
                width: 231,
                height: 31,
                child: Text(
                  'Wheel You Choose?',
                  textAlign: TextAlign.center,
                  style: AppTextTheme.fallback().basicText?.copyWith(color: Colors.black) ??
                      TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
