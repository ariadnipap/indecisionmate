import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/screens/set_new_password.dart';
import '/screens/add_your_event.dart';
import '/text/app_text_themes.dart';
import '/colors/app_color_themes.dart';
import '/widgets/read_only_text_input.dart';
import '/widgets/profile_picture.dart';
import '/widgets/my_profile_drag.dart';
import '/screens/welcome_page.dart';
import '/screens/edit_profile.dart';
import '/screens/choose_your_interests.dart';
import '/screens/my_list.dart';
import '/widgets/in_out.dart';
import '/widgets/edit_profile_button.dart';
import 'package:intl/intl.dart';
import '/widgets/navigation_bar.dart';
import '/screens/activities.dart';
import '/screens/friends.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  static const String routeName = '/profile';
  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}


class _ProfilePage extends State<ProfilePage> {
  late String userId;
  int currentPageIndex = 2;
 late List<Widget> pages;

  @override
  void initState() {
    super.initState();

    userId = widget.userId;

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
      backgroundColor: AppColors.backround,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 69),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: EditProfileButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => EditProfile(userId: userId)),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 238,
                    height: 45,
                    child: Text(
                      'Your profile',
                      textAlign: TextAlign.center,
                      style: AppTextTheme.fallback().smallerTitle,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Display the profile picture from the URL in the user's data
                  ProfilePicture(imageUrl: userData['ProfilePicture'] ?? "https://via.placeholder.com/112x112"),

                  SizedBox(height: 20),

                  ReadOnlyTextInput(
                    labelText: 'Username',
                    value: userData['Username'] ?? '',
                  ),
                  SizedBox(height: 15),
                  ReadOnlyTextInput(
                    labelText: 'Name',
                    value: userData['Name'] ?? '',
                  ),
                  SizedBox(height: 15),
                  ReadOnlyTextInput(
                    labelText: 'Phone Number',
                    value: userData['Phone Number'] ?? '',
                  ),
                  SizedBox(height: 15),
                  ReadOnlyTextInput(
                    labelText: 'Email',
                    value: userData['Email'] ?? '',
                  ),
                  SizedBox(height: 15),
                  ReadOnlyTextInput(
                    labelText: 'Date of Birth',
                    value: userData['DateOfBirth'] != null
                        ? DateFormat('dd-MM-yyyy').format((userData['DateOfBirth'] as Timestamp).toDate())
                        : '',
                  ),
                  

                  SizedBox(height: 20),
                  SlideButton(text: 'Change Password', page: SetNewPassword()),
                  SlideButton(text: 'Edit Interests', page: ChooseYourInterestsPage(userId: userId)),
                  SlideButton(text: 'Add Your Event', page: AddYourEvent(userId: widget.userId)),
                  SlideButton(text: 'My List', page: MyList(userId: userId)),
                  SizedBox(height: 20),

                  InOutWidget(
                    text: 'Sign Out',
                    color: AppColors.red,
                    onPressed: () {
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
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: 2,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });

         
          // Navigate to the corresponding page
           /*Navigator.of(context).push(
            NoAnimationMaterialPageRoute(
              builder: (context) => pages[currentPageIndex],
            ),
          );*/
        },
      ),


    );
  }
}
