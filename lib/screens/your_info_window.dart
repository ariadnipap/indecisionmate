import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/colors/app_color_themes.dart';
import '/screens/suggestions.dart';

class YourInfoWindow extends StatelessWidget {
  final String eventName;
  final String eventThemeAndRules;
  final String eventWhen;
  final GeoPoint eventWhere;
  final Function()? onDismiss;
  final String userId; // Add this line

  const YourInfoWindow({
    Key? key,
    required this.eventName,
    required this.eventThemeAndRules,
    required this.eventWhen,
    required this.eventWhere,
    this.onDismiss,
    required this.userId, // Add this line
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          if (onDismiss != null) {
            onDismiss!();
          }
        },
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.logo,
              borderRadius: BorderRadius.circular(16),
            ),
            child: contentBox(context),
          ),
        ),
      ),
    );
  }

  contentBox(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          eventName,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        SizedBox(height: 15),
        Text(
          'Event Theme and Rules: $eventThemeAndRules',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        SizedBox(height: 15),
        Text(
          'Event When: $eventWhen',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        SizedBox(height: 15),
        Text(
          'Event Where: Latitude ${eventWhere.latitude}, Longitude ${eventWhere.longitude}',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        SizedBox(height: 22),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onDismiss != null) {
              onDismiss!();
            }
            // Navigate back to SuggestionsPage
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SuggestionsPage(userId: userId)));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(AppColors.seeThroughText), // Change the color here
          ),
          child: Text('Close'),
        ),
      ],
    );
  }
}
