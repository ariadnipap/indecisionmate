import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/colors/app_color_themes.dart';
import '/widgets/custom_text_input.dart';
import '/widgets/login_button.dart';
import '/text/app_text_themes.dart';
import '/screens/activities.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.backround,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text(
              'Login to your',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Fugaz One',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
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
                    child: Image.asset('assets/logo.png'),
                  ),
                  const SizedBox(width: 0),
                  SizedBox(
                    width: 280,
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
                              color: AppColors.logo,
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
            const SizedBox(height: 20),
            CustomTextInput(
              labelText: 'Username',
              controller: usernameController,
              top: 20,
              labelStyle: AppTextTheme.fallback()?.basicText ?? TextStyle(),
            ),
            const SizedBox(height: 20),
            CustomTextInput(
              labelText: 'Password',
              controller: passwordController,
              top: 20,
              labelStyle: AppTextTheme.fallback()?.basicText ?? TextStyle(),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 200,
              height: 100,
              child: Text(
                'Forgot your password?',
                textAlign: TextAlign.center,
                style: AppTextTheme.fallback().underlinedBasicText,
              ),
            ),
            LoginButton(
              onPressed: () async {
                final String username = usernameController.text;

                try {
                  // Check if the user with the given username exists in your database
                  // You need to implement this logic according to your database structure
                  bool userExists = await checkIfUserExists(username);

                  if (userExists) {
                    // If the user exists, attempt to sign in
                    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                      email: '$username@yourdomain.com',
                      password: passwordController.text,
                    );

                    // Access the user ID
                    String userId = userCredential.user?.uid ?? "";

                    // Navigate to ChooseYourMood page with user ID
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActivitiesPage(userId: userId),
                      ),
                    );
                  } else {
                    // Handle the case where the user does not exist
                    print("User with username $username does not exist");
                    // Show a snackbar or dialog to inform the user
                  }
                } catch (e) {
                  // Handle login errors (e.g., wrong credentials)
                  print("Login failed: $e");
                  // Show a snackbar or dialog to inform the user about the failure
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> checkIfUserExists(String username) async {
    // Assuming you have a collection named 'users' in Firestore
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('Username', isEqualTo: username)
        .get();

    return result.docs.isNotEmpty;
  }
}
