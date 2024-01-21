import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';

 class ToggleCustomTextInput extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final double top;
  final TextStyle labelStyle;

  const ToggleCustomTextInput({
    required this.labelText,
    required this.controller,
    required this.top,
    required this.labelStyle,
  });

  @override
  _ToggleCustomTextInputState createState() => _ToggleCustomTextInputState();
}

class _ToggleCustomTextInputState extends State<ToggleCustomTextInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 293.12,
      height: 87.36,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              width: 289,
              height: 25,
              child: Text(
                widget.labelText,
                style: widget.labelStyle,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 30, // Adjust the top offset for the text field
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
                    left: 12, // Adjust the left padding for the text field
                    top: 3, // Adjust the top padding for the text field
                    child: SizedBox(
                      width: 280, // Adjust the width of the text field
                      height: 29, // Adjust the height of the text field
                      child: TextFormField(
                        controller: widget.controller,
                        style: AppTextTheme.fallback()?.basicText ?? TextStyle(),
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
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
    );
  }
}