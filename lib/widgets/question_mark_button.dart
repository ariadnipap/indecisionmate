import 'package:flutter/material.dart';
import '/text/app_text_themes.dart';

class QuestionMarkButton extends StatelessWidget {
  final Widget targetPage;

  QuestionMarkButton({required this.targetPage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
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
