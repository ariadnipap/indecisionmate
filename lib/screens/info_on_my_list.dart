import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';
import '/widgets/exit_button.dart'; 
import '/screens/my_list.dart';

class ParentWidget extends StatelessWidget {
  final String userId;

  ParentWidget({required this.userId});

  @override
  Widget build(BuildContext context) {
    return InformationOnMyList(userId: userId);
  }
}

class InformationOnMyList extends StatelessWidget {
  final String userId;
  final _formKey = GlobalKey<FormState>();

  InformationOnMyList({required this.userId});

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
                    'What is My list?',
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
                          text: 'In this page, you see all the activities you have put in your list from the suggestions page! Click on a card to remove the activity.',
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
                      MaterialPageRoute(builder: (context) => MyList(userId: userId)),
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