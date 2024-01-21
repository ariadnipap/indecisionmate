import 'package:flutter/material.dart';
import '/widgets/navigation_bar.dart';
import '/screens/activities.dart';
import '/screens/profile.dart';
import '/colors/app_color_themes.dart';

class FriendsPage extends StatefulWidget {
  final String userId;
  const FriendsPage({Key? key, required this.userId}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  int currentPageIndex = 0; // Set the default index to 'Friends'
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
      ),
      body: Center(
        child: Text('Friends'),
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
