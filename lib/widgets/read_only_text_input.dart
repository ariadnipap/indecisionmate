import 'package:flutter/material.dart';
import '/text/app_text_themes.dart';
import '/colors/app_color_themes.dart';

class ReadOnlyTextInput extends StatelessWidget {
  final String labelText;
  final String value;

  const ReadOnlyTextInput({
    required this.labelText,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 35,
      child: SizedBox(
        width: 293.12,
        height: 87.36,
        child: Stack(
          children: [
            Positioned(
              left: 0.0,
              top: 0,
              child: SizedBox(
                width: 289,
                height: 25,
                child: Text(
                  labelText,
                  style: AppTextTheme.fallback().basicText ?? TextStyle(),
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
                        decoration: BoxDecoration(color: AppColors.seeThroughText),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: 3,
                      child: SizedBox(
                        width: 280,
                        height: 40,
                        child: Center(
                          child: Text(
                            value,
                            style: AppTextTheme.fallback().basicText ?? TextStyle(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}