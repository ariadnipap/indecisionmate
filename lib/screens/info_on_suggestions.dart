import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';
import '/widgets/exit_button.dart'; 
import '/screens/suggestions.dart';

class ParentWidget extends StatelessWidget {
  final String userId;

  ParentWidget({required this.userId});

  @override
  Widget build(BuildContext context) {
    return InformationOnSuggestions(userId: userId);
  }
}

class InformationOnSuggestions extends StatelessWidget {
  final String userId;
  final _formKey = GlobalKey<FormState>();

  InformationOnSuggestions({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backround,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 69),
                SizedBox(
                  //width: 238,
                  height: 45,
                  child: Text(
                    'What are suggestions?',
                    textAlign: TextAlign.center,
                    style: AppTextTheme.fallback().smallerTitle,
                  ),
                ),
                SizedBox(height: 20), // Adjust spacing

                SizedBox(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'In this page, you are presented with many cards. Each one suggests an activity for you. We are proposing suggestions based on your choices as well as events that other users of the app are organizing near you. Click on a card to select it. For the undecisive ones: You can select at leas 2 and at most 6 activities to spin a wheel that picks one of your choices for you! Double tap on an activity to put it in your list. Long press on an event to view more details about it.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Fugaz One',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),

                SizedBox(height: 20),
                // Add ExitButton here
                ExitButton(
                  onPressed: () {
                    // Navigate back to the welcome page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SuggestionsPage(userId: userId)),
                    );
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
