import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';

class ErrorCustomTextInput extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final double top;
  final TextStyle labelStyle;
  final bool showError;
  final Function(String)? validator;

  const ErrorCustomTextInput({
    required this.labelText,
    required this.controller,
    required this.top,
    required this.labelStyle,
    required this.showError,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 293.12,
      height: 110, // Adjusted height to accommodate the error message
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              width: 289,
              height: 25,
              child: Text(
                labelText,
                style: labelStyle,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 30,
            child: SizedBox(
              width: 293,
              height: 49,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 293,
                      height: 49,
                      decoration: BoxDecoration(
                        color: showError ? Colors.red : AppColors.seeThroughText,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 3,
                    child: SizedBox(
                      width: 280,
                      height: 40,
                      child: TextField(
                        controller: controller,
                        style: AppTextTheme.fallback().basicText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(0),
                        ),
                        onChanged: validator != null ? (value) => validator!(value) : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 81, // Adjusted top position for the error message
            child: SizedBox(
              width: 280,
              child: Text(
                showError ? 'Username already exists' : '',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}