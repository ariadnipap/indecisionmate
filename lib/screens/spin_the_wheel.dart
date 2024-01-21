import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';
import 'dart:math' as math;
import '/widgets/navigation_bar.dart';
import '/screens/friends.dart';
import '/screens/profile.dart';
import '/screens/activities.dart';

class MyFortuneWheel extends StatefulWidget {
  final String userId;
  final List<String> selectedSuggestions;

  const MyFortuneWheel({Key? key, required this.userId, required this.selectedSuggestions}) : super(key: key);

  @override
  _MyFortuneWheel createState() => _MyFortuneWheel();
}

class _MyFortuneWheel extends State<MyFortuneWheel> {
  final StreamController<int> controller = StreamController<int>();
  int currentPageIndex = 1;
  int selectedIndex = -1;
  late List<Widget> pages;
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    // Initialize the pages list in the initState method
    pages = [
      FriendsPage(userId: widget.userId),
      ActivitiesPage(userId: widget.userId),
      ProfilePage(userId: widget.userId),
    ];

    // Initialize items with selectedSuggestions
    items = widget.selectedSuggestions;

    // If fewer than 6 suggestions are provided, add empty placeholders
    while (items.length < 6) {
      items.add('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> itemColors = [
      AppColors.red,
      AppColors.yellow,
      AppColors.green,
      AppColors.blue,
      AppColors.lightBlue,
      AppColors.pink,
    ];

    return Scaffold(
      backgroundColor: AppColors.backround,
      body: Column(
        children: [
          const SizedBox(height: 50),
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
            child: Center(
              child: FortuneWheel(
                // Set animateFirst to false so the wheel does not spin automatically
                animateFirst: false,
                hapticImpact: HapticImpact.medium,
                indicators: <FortuneIndicator>[
                  FortuneIndicator(
                    alignment: Alignment.topCenter,
                    child: TriangleIndicator(
                      color: Colors.black,
                    ),
                  ),
                ],
                physics: CircularPanPhysics(
                  duration: Duration(seconds: 1),
                  curve: Curves.decelerate,
                ),

                // Make it random but save the value
                onFling: () {
                  int value = math.Random().nextInt(items.length);
                  controller.add(value);
                  setState(() {
                    selectedIndex = value;
                  });
                  print(items[value]);
                },

                selected: controller.stream,
                items: [
                  for (var i = 0; i < items.length; i++)
                    FortuneItem(
                      child: Transform.rotate(
                        angle: i > (items.length / 2) ? math.pi : 0,
                        child: Text(
                          items[i],
                          style: AppTextTheme.fallback().wheel,
                        ),
                      ),
                      style: FortuneItemStyle(
                        color: itemColors[i],
                        borderColor: Colors.black,
                        borderWidth: 4,
                      ),
                    ),
                ],
              ),
            ),
          ),

          Text(
            selectedIndex != -1 ? 'Selected: ${items[selectedIndex]}' : 'Spin the wheel!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: "Fugaz One",
            ),
          ).animate(
            // delay: 1000.ms,
            //onPlay: (controller) => controller.repeat(), // loop
          ).fade(duration: 600.ms).callback(duration: 300.ms, callback: (_) => print('halfway')).tint(
            color: selectedIndex != -1 ? itemColors[selectedIndex] : Colors.white,
          ),
          const SizedBox(height: 20)
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
}
