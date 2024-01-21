import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';
import '/screens/profile.dart'; // Adjust the import path based on your project structure

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String userId;

  SaveButton({Key? key, required this.onPressed, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Handle save logic here
        onPressed();

        // Navigate to MyProfile screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(userId: userId)),
        );
      },
      child: Container(
        width: 135,
        height: 36,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Save',
                    textAlign: TextAlign.center,
                    style: AppTextTheme.fallback().suggestions?.copyWith(color: Colors.black) ??
                        TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

