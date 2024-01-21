import 'package:flutter/material.dart';
import 'package:indecisionmate/text/app_text_themes.dart';
import '/widgets/navigation_bar.dart';
import '/screens/friends.dart';
import '/screens/profile.dart';
import '/colors/app_color_themes.dart';
import '/screens/choose_your_mood.dart';
import '/widgets/continue_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivitiesPage extends StatefulWidget {
  final String userId;

  const ActivitiesPage({Key? key, required this.userId}) : super(key: key);

  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  int currentPageIndex = 1;
  String selectedBox = '';

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      FriendsPage(userId: widget.userId),
      ActivitiesPage(userId: widget.userId),
      ProfilePage(userId: widget.userId),
    ];

    return Scaffold(
      backgroundColor: AppColors.backround,
      body: Column(
        children: [
          SizedBox(height: 74),
          /*SizedBox(
            width: 267,
            height: 54,
            child: Center(
              child: Text(
                'Welcome to your',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontFamily: 'Fugaz One',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 14),
          Container(
            width: 380,
            height: 54,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 44,
                  child: Image.asset('assets/logo.png'),
                ),
                SizedBox(
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
          ),*/
          SizedBox(height: 51),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGridBox('Me, Myself & I', AppColors.blue),
              SizedBox(width: 30),
              _buildGridBox('Couples', AppColors.red),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGridBox('Friends', AppColors.green),
              SizedBox(width: 30),
              _buildGridBox('Family', AppColors.yellow),
            ],
          ),
          SizedBox(height: 30),
            Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContinueButton(
                onPressed: () async {
                  print(selectedBox);

                  // Map each box to its corresponding value
                  Map<String, String> boxValues = {
                    'Me, Myself & I': 'Alone',
                    'Friends': 'Friends',
                    'Family': 'Family',
                    'Couples': 'Couples',
                  };

                  // Add the selected choice to Firestore if not empty
                  if (selectedBox.isNotEmpty && boxValues.containsKey(selectedBox)) {
                    await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
                      'People': boxValues[selectedBox],
                    });
                  }

                  // Navigate to the next page (ChooseYourMood)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseYourMood(userId: widget.userId),
                    ),
                  );
                },
                width: 150,
                height: 50,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });

          // Navigate to the corresponding page
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => pages[currentPageIndex]),
          );
        },
      ),
    );
  }

  Widget _buildGridBox(String text, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBox = text;
        });
      },
      child: Container(
        width: 142,
        height: 167,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: selectedBox == text ? Border.all(color: Colors.white, width: 3.0) : null,
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextTheme.fallback().basicText,
          ),
        ),
      ),
    );
  }
}
