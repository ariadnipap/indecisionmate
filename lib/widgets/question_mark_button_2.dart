import 'package:flutter/material.dart';
import '/text/app_text_themes.dart';

class QuestionMarkButton2 extends StatelessWidget {
  final void Function() onTapCallback;

  QuestionMarkButton2({required this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        margin: EdgeInsets.only(top: 20, right: 10),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF321B34),
        ),
        child: Center(
          child: Text(
            '?',
            textAlign: TextAlign.center,
            style: AppTextTheme.fallback().seeThroughText,
          ),
        ),
      ),
    );
  }
}
