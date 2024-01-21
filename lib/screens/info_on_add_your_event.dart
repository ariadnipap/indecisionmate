import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';
import '/widgets/exit_button.dart'; 
import '/screens/add_your_event.dart';

class ParentWidget extends StatelessWidget {
  final String userId;

  ParentWidget({required this.userId});

  @override
  Widget build(BuildContext context) {
    return InformationOnAddYourEvent(userId: userId);
  }
}

class InformationOnAddYourEvent extends StatelessWidget {
  final String userId;
  final _formKey = GlobalKey<FormState>();

  InformationOnAddYourEvent({required this.userId});

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
                    'What is "Add your event"?',
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
                          text: 'Our application gives you the option to add your own event! Simply choose a name, a time and give a description of the theme and the event rules and you are good to go. We will scan your location and propose your event to all the users that are at a 20km radius from you!',
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
                      MaterialPageRoute(builder: (context) => AddYourEvent(userId: userId)),
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