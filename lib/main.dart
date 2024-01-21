import 'package:flutter/material.dart';
import 'screens/welcome_page.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized before Firebase

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const WelcomeApp());
}


class WelcomeApp extends StatelessWidget {
  const WelcomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
    );
  }
}
