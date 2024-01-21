import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';

class UploadPhotoButton extends StatelessWidget {
  final VoidCallback onPressed;

  UploadPhotoButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 160,
            height: 47,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: ShapeDecoration(
              color: AppColors.logo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Center(
              child: Text(
                'Upload Photo',
                style: AppTextTheme.fallback().basicText?.copyWith(
                      fontSize: 16,
                    ) ?? TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

