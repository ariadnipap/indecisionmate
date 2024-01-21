import 'package:flutter/material.dart';
import '/screens/login_page.dart';
import '/screens/signup_page.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart'; 
import '/widgets/login_button.dart';
import '/widgets/question_mark_button.dart';
import '/screens/info_welcome_page.dart';
import '/widgets/signup_button.dart'; // Import the SignUpButton widget

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backround,
      body: Center(
        child: Stack(
          children: [
            // Positioned widgets instead of Column for maintaining the layout
            Positioned(
              left: 0,
              top: 150,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 316,
                      height: 114,
                      child: Text(
                        'Don\'t Just Sit, \nEmbark On An Adventure \nGuided By Your',
                        textAlign: TextAlign.center,
                        style: AppTextTheme.fallback().basicText,
                      ),
                    ),
                    SizedBox(
                      width: 344,
                      height: 50,
                      child: Text(
                        'IndecisionMate',
                        textAlign: TextAlign.center,
                        style: AppTextTheme.fallback().title,
                      ),
                    ),
                    SizedBox(height: 60), // Adjust spacing between components

                    // Log in button
                    LoginButton(
                      onPressed: () {
                        final String username = usernameController.text;
                        final String password = passwordController.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                    SizedBox(height: 40), // Adjust spacing between components

                    // Sign up button
                    SignUpButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                    ),
                    SizedBox(height: 60), // Adjust spacing between components

                    // Placeholder for the logo image
                    Container(
                      width: 86,
                      height: 88,
                      child: Center(
                        child: Image.asset('assets/logo.png'), 
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Circular button with the question mark
            Positioned(
              right: 20,
              top: 20,
              child: QuestionMarkButton(targetPage: InformationOnMainpage()),
            ),
          ],
        ),
      ),
    );
  }
}