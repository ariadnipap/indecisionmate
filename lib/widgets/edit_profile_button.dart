import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';

class EditProfileButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditProfileButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 43,
        height: 42,
        decoration: ShapeDecoration(
          color: AppColors.seeThroughText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x4C000000),
              blurRadius: 3,
              offset: Offset(0, 1),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 8,
              offset: Offset(0, 4),
              spreadRadius: 3,
            )
          ],
        ),
        child:
            Icon(Icons.edit, size :24),
      ),
    );
  }
}
