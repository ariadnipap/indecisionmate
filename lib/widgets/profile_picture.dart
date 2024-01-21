import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';

class ProfilePicture extends StatelessWidget {
  final String imageUrl;

  const ProfilePicture({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 112,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.seeThroughText, // Default grey color
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipOval(
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
