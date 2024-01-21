import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';
import '/widgets/interest.dart';
import '/widgets/continue_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/screens/choose_your_mood.dart';

class ChooseYourInterestsPage extends StatefulWidget {
  final String userId;

  ChooseYourInterestsPage({required this.userId});

  @override
  _ChooseYourInterestsPageState createState() => _ChooseYourInterestsPageState();
}

class _ChooseYourInterestsPageState extends State<ChooseYourInterestsPage> {
  List<String> selectedInterests = [];

  @override
  void initState() {
    super.initState();
    fetchUserInterests();
  }

  Future<void> fetchUserInterests() async {
    List<String> userInterests = await getUserInterests(widget.userId);
    setState(() {
      selectedInterests = userInterests;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backround,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 76,
                child: Center(
                  child: Text(
                    'Choose your interests!',
                    style: AppTextTheme.fallback().smallerTitle?.copyWith(color: Colors.white)
                        ?? TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Interest(
                label: 'Music',
                color: AppColors.red,
                isSelected: selectedInterests.contains('Music'),
                onToggle: (label) => toggleInterest(label),
              ),
              SizedBox(height: 10),
              Interest(
                label: 'Movies & TV Shows',
                color: AppColors.yellow,
                isSelected: selectedInterests.contains('Movies & TV Shows'),
                onToggle: (label) => toggleInterest(label),
              ),
              SizedBox(height: 10),
              Interest(
                label: 'Nature & Animals',
                color: AppColors.blue,
                isSelected: selectedInterests.contains('Nature & Animals'),
                onToggle: (label) => toggleInterest(label),
              ),
              SizedBox(height: 10),
              Interest(
                label: 'Food & Drinks',
                color: AppColors.lightBlue,
                isSelected: selectedInterests.contains('Food & Drinks'),
                onToggle: (label) => toggleInterest(label),
              ),
              SizedBox(height: 10),
              Interest(
                label: 'Art',
                color: AppColors.pink,
                isSelected: selectedInterests.contains('Art'),
                onToggle: (label) => toggleInterest(label),
              ),
              SizedBox(height: 10),
              Interest(
                label: 'Parties',
                color: AppColors.green,
                isSelected: selectedInterests.contains('Parties'),
                onToggle: (label) => toggleInterest(label),
              ),
              SizedBox(height: 10),
              Interest(
                label: 'Sports & Fitness',
                color: AppColors.red,
                isSelected: selectedInterests.contains('Sports & Fitness'),
                onToggle: (label) => toggleInterest(label),
              ),
              SizedBox(height: 10),
              Interest(
                label: 'Culture',
                color: AppColors.yellow,
                isSelected: selectedInterests.contains('Culture'),
                onToggle: (label) => toggleInterest(label),
              ),
              SizedBox(height: 10),
              Interest(
                label: 'Lifestyle',
                color: AppColors.blue,
                isSelected: selectedInterests.contains('Lifestyle'),
                onToggle: (label) => toggleInterest(label),
              ),
              SizedBox(height: 10),
              Interest(
                label: 'Learning',
                color: AppColors.lightBlue,
                isSelected: selectedInterests.contains('Learning'),
                onToggle: (label) => toggleInterest(label),
              ),
              SizedBox(height: 10),
              Interest(
                label: 'Fashion & Beauty',
                color: AppColors.pink,
                isSelected: selectedInterests.contains('Fashion & Beauty'),
                onToggle: (label) => toggleInterest(label),
              ),
              SizedBox(height: 10),
              Interest(
                label: 'Board Games',
                color: AppColors.green,
                isSelected: selectedInterests.contains('Board Games'),
                onToggle: (label) => toggleInterest(label),
              ),
              
              const SizedBox(height: 20),

              ContinueButton(
                onPressed: () async {
                  await updateUserInterests(selectedInterests);
                  print("Interests updated: $selectedInterests");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseYourMood(userId: widget.userId),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void toggleInterest(String label) {
    setState(() {
      if (selectedInterests.contains(label)) {
        selectedInterests.remove(label);
      } else {
        selectedInterests.add(label);
      }
    });
  }

  Future<void> updateUserInterests(List<String> interests) async {
    try {
      String userId = widget.userId;
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'Interest': interests,
      });
    } catch (e) {
      print("Error updating interests: $e");
    }
  }

  Future<List<String>> getUserInterests(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return List<String>.from(userDoc.get('interests'));
      }
    } catch (e) {
      // Handle any errors
      print("Error fetching user interests: $e");
    }
    return [];
  }
}
