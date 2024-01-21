import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';

class PasswordCustomTextInput extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final double top;
  final TextStyle labelStyle;
  final bool showError;
  final Function(String)? validator;

  const PasswordCustomTextInput({
    required this.labelText,
    required this.controller,
    required this.top,
    required this.labelStyle,
    required this.showError,
    this.validator,
  });

  @override
  _PasswordCustomTextInputState createState() => _PasswordCustomTextInputState();
}

class _PasswordCustomTextInputState extends State<PasswordCustomTextInput> {
  bool _obscureText = true;

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
                widget.labelText,
                style: widget.labelStyle,
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
                        color: widget.showError ? Colors.red : AppColors.seeThroughText,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 3,
                    child: SizedBox(
                      width: 250, // Adjusted width to accommodate the toggle eye icon
                      height: 40,
                      child: TextField(
                        controller: widget.controller,
                        obscureText: _obscureText,
                        style: AppTextTheme.fallback().basicText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(0),
                        ),
                        onChanged: (value) {
                          if (widget.validator != null) {
                            widget.validator!(value);
                          }
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 3,
                    child: IconButton(
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
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 79, 
            child: SizedBox(
              width: 280,
              child: Text(
                widget.showError ? 'Password should have at least 8 characters '
                    'and include a letter, a number, and a symbol.' : '',
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