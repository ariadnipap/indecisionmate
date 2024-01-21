// navigation_bar.dart
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: NavigationBar(
        backgroundColor: const Color(0xFFD42AFF),
        onDestinationSelected: onDestinationSelected,
        indicatorColor: Colors.purple,
        selectedIndex: selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.people_alt, size: 35),
            icon: Icon(Icons.people_alt, size: 35),
            label: 'Friends',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.rocket_launch, size: 35),
            icon: Icon(Icons.rocket_launch_outlined, size: 35),
            label: 'Activities',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person, size: 35),
            icon: Icon(Icons.person, size: 35),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
