import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String suggestion;

  DetailsPage({required this.suggestion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Details for suggestion:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              suggestion,
              style: TextStyle(fontSize: 16),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
