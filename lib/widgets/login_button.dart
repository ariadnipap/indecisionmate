import 'package:flutter/material.dart';
import '/text/app_text_themes.dart';
import '/colors/app_color_themes.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

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
                color: AppColors.logIn, // Log in color
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0), // Set elevation to 0
                overlayColor: MaterialStateProperty.all(Colors.transparent), // Set overlay color to transparent
                backgroundColor: MaterialStateProperty.all(Colors.transparent), // Log in color
              ),
              child: Text(
                'Log In',
                style: AppTextTheme.fallback().seeThroughText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
