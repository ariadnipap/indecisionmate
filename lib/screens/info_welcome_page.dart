import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';
import '/widgets/exit_button.dart'; 
import '/screens/welcome_page.dart';

class InformationOnMainpage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
                  width: 238,
                  height: 45,
                  child: Text(
                    'What is',
                    textAlign: TextAlign.center,
                    style: AppTextTheme.fallback().smallerTitle,
                  ),
                ),
                SizedBox(height: 10), // Adjust spacing

                SizedBox(
                  width: 344,
                  height: 50,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/logo2.png'),
                      ),
                      const SizedBox(width: 10), // Adjust spacing
                      SizedBox(
                        width: 300,
                        height: 100,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Indecision',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 39,
                                  fontFamily: 'Fugaz One',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: 'Mate',
                                style: TextStyle(
                                  color: Color(0xFCD42AFF),
                                  fontSize: 39,
                                  fontFamily: 'Fugaz One',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Adjust spacing

                SizedBox(
                  //width: 282,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Indecision',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Fugaz One',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        TextSpan(
                          text: 'Mate',
                          style: TextStyle(
                            color: Color(0xFCD42AFF),
                            fontSize: 24,
                            fontFamily: 'Fugaz One',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        TextSpan(
                          text: ' is an application designed to help you fill in your free time with interesting activities. Sign up with your email and phone number and choose your interests. Don’t worry, you can change them later! Every time you log in, choose your mood and your budget (can also be changed later), find your friends, view personalized suggestions and embark on this amazing journey!',
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
                      MaterialPageRoute(builder: (context) => WelcomePage()),
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
