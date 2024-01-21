import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';
import '/widgets/continue_button.dart';
import '/widgets/emoji.dart';
import '/widgets/budget.dart';
import '/widgets/in_out.dart';
import '/screens/suggestions.dart';
import '/widgets/navigation_bar.dart';
import '/screens/friends.dart';
import '/screens/profile.dart';
import '/screens/activities.dart';
import '/screens/suggestions.dart';

class ChooseYourMood extends StatefulWidget {
  final String userId;

  const ChooseYourMood({Key? key, required this.userId}) : super(key: key);

  @override
  _ChooseYourMoodState createState() => _ChooseYourMoodState();
}

class _ChooseYourMoodState extends State<ChooseYourMood> {
  List<String> mood = [];
  List<String> inout = [];
  List<String> budget = [];
  int currentPageIndex = 1;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();

    // Initialize the pages list in the initState method
    pages = [
      FriendsPage(userId: widget.userId),
      ActivitiesPage(userId: widget.userId),
      ProfilePage(userId: widget.userId),
    ];
  }

// Emojis
  List<String> emojiImages = [
    'assets/images/angry_emoji.png',
    'assets/images/happy_emoji.png',
    'assets/images/in_love_emoji.png',
    'assets/images/meh_emoji.png',
    'assets/images/moody_emoji.png',
    'assets/images/nerd_emoji.png',
    'assets/images/party_emoji.png',
    'assets/images/playful_emoji.png',
    'assets/images/sleepy_emoji.png',
  ];

  // Budgets
  List<String> budgetImages = [
    'assets/images/low_budget_emoji.png',
    'assets/images/medium_budget_emoji.png',
    'assets/images/high_budget_emoji.png',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backround,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50),
          // Logo and App Name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', width: 50, height: 44),
                Text.rich(
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
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Section Title
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      'Choose your Mood & Budget',
                      textAlign: TextAlign.center,
                      style: AppTextTheme.fallback().smallerTitle,
                    ),
                  ),
                  // In-Out Widgets
                  SizedBox(height: 17),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InOutWidget(
                          text: 'Stay In',
                          color: AppColors.yellow,
                          onPressed: () => updateList('inout', 'Stay In'),
                        ),
                        InOutWidget(
                          text: 'Go Out',
                          color: AppColors.blue,
                          onPressed: () => updateList('inout', 'Go Out'),
                        ),
                      ],
                    ),
                  ),
                  // Emojis
                  SizedBox(height: 30),
                  buildEmojiRow(0),
                  SizedBox(height: 20),
                  buildEmojiRow(3),
                  SizedBox(height: 20),
                  buildEmojiRow(6),
                  // Budgets
                  SizedBox(height: 20),
                  buildBudgetRow(),
                ],
              ),
            ),
          ),
          // Continue Button
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContinueButton(
                onPressed: () async {
                  await storeUserMoodInfo();
                  print("Mood: $mood");
                  print("InOut: $inout");
                  print("Budget: $budget");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuggestionsPage(userId: widget.userId)),
                  );
                },
                width: 150,
                height: 50,
              ),
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => pages[currentPageIndex]),
          );
        },
      ),
    );
  }

 Widget buildEmojiRow(int startIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < 3; i++)
          EmojiWidget(
            image: Image.asset(emojiImages[startIndex + i]),
            onPressed: () => updateList('mood', getMoodText(startIndex + i)),
          ),
      ],
    );
  }

  Widget buildBudgetRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (index) {
        return DollarWidget(
          image: Image.asset(budgetImages[index]),
          onPressed: () => updateList('budget', getBudgetText(index)),
        );
      }),
    );
  }

  String getMoodText(int index) {
    switch (index) {
      case 0:
        return 'angry';
      case 1:
        return 'happy';
      case 2:
        return 'in_love';
      case 3:
        return 'meh';
      case 4:
        return 'moody';
      case 5:
        return 'nerd';
      case 6:
        return 'party';
      case 7:
        return 'playful';
      case 8:
        return 'sleepy';
      default:
        return '';
    }
  }

  String getBudgetText(int index) {
    switch (index) {
      case 0:
        return 'low';
      case 1:
        return 'medium';
      case 2:
        return 'high';
      default:
        return '';
    }
  }

Future<void> storeUserMoodInfo() async {
    try {
      // Access the userId using widget.userId
      String userId = widget.userId;

      // Update mood, inout, and budget in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'Mood': mood,
        'InOut': inout,
        'Budget': budget,
      });
    } catch (e) {
      // Handle any errors
      print("Error updating user mood info: $e");
    }
  }


  void updateList(String listType, String text) {
    setState(() {
      switch (listType) {
        case 'mood':
          if (mood.contains(text)) {
            mood.remove(text);
          } else {
            mood.add(text);
          }
          break;
        case 'inout':
          if (inout.contains(text)) {
            inout.remove(text);
          } else {
            inout.add(text);
          }
          break;
        case 'budget':
          if (budget.contains(text)) {
            budget.remove(text);
          } else {
            budget.add(text);
          }
          break;
      }
    });
  }
}