import 'dart:math';
import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/widgets/suggestion.dart';
import '/widgets/wheel_you_choose_button.dart';
import '/text/app_text_themes.dart';
import '/widgets/question_mark_button_2.dart'; //
import 'package:cloud_firestore/cloud_firestore.dart';
import '/screens/spin_the_wheel.dart';
import 'package:geolocator/geolocator.dart';
import '/screens/your_info_window.dart';
import 'package:shared_preferences/shared_preferences.dart'; //edw
import '/screens/info_on_suggestions.dart';

class SuggestionsPage extends StatefulWidget {
  final List<String>? suggestions;
  final String userId;

  SuggestionsPage({Key? key, this.suggestions, required this.userId}) : super(key: key);

  @override
  _SuggestionsPageState createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  List<String> selectedSuggestions = [];
  List<String> mylist = [];
  late String userId; //edw

  Color getRandomColor() {
    final List<Color> colors = [
      AppColors.blue,
      AppColors.lightBlue,
      AppColors.pink,
      AppColors.green,
      AppColors.red,
      AppColors.yellow,
    ];
    final random = Random();
    return colors[random.nextInt(colors.length)];
  }

  bool isInMyList(String item) {
    return mylist.contains(item);
  }

  @override
    void initState() {
    super.initState();
    userId = widget.userId; //edw
    // Fetch existing mylist from Firebase when the widget initializes
    fetchExistingMyList();
    fetchSavedSelectedSuggestions();
  }

  void fetchSavedSelectedSuggestions() async { //edw
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedSelectedSuggestions = prefs.getStringList('selectedSuggestions');

    if (savedSelectedSuggestions != null) {
      setState(() {
        selectedSuggestions = savedSelectedSuggestions;
      });
    }
  }

  void saveSelectedSuggestions() async { //edw
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selectedSuggestions', selectedSuggestions);
  }

  Future<void> fetchExistingMyList() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      if (userData.containsKey('mylist')) {
        setState(() {
          mylist = List<String>.from(userData['mylist']);
        });
      }
    } catch (error) {
      print('Error fetching existing mylist: $error');
    }
  }
  Widget build(BuildContext context) {

    return Material(
      color: AppColors.backround,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 69),
                Text(
                  'Your',
                  textAlign: TextAlign.center,
                  style: AppTextTheme.fallback().smallerTitle,
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
                Text(
                  'suggests:',
                  textAlign: TextAlign.center,
                  style: AppTextTheme.fallback().smallerTitle,
                ),
                SizedBox(height: 16),

                FutureBuilder(
                  future: fetchMatchingSuggestions(),
                  builder: (context, AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Wrap(
                        spacing: 16.0,
                        runSpacing: 16.0,
                        children: List.generate(snapshot.data!.length, (index) {
                          return SuggestionCard(
                            text: snapshot.data![index],
                            color: getRandomColor(),
                            xPosition: index % 2 * 150.0,
                            yPosition: (index ~/ 2) * 120.0,
                            onSelectionChanged: (isSelected) {
                              String suggestion = snapshot.data![index];
                              if (isSelected && selectedSuggestions.length < 6) {
                                setState(() {
                                  selectedSuggestions.add(suggestion);
                                  saveSelectedSuggestions(); //edw
                                });
                              } else {
                                setState(() {
                                  selectedSuggestions.remove(suggestion);
                                  saveSelectedSuggestions(); //edw
                                });
                              }
                            },
                            initiallySelected: selectedSuggestions.contains(snapshot.data![index]),
                            onDoubleTap: () {
                              // Add the suggestion to mylist if it's not already there
                              if (!isInMyList(snapshot.data![index])) {
                                mylist.add(snapshot.data![index]);

                                FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
                                  'mylist': mylist,
                                });
                              }
                            },
                          );
                        }),
                      );
                    } else {
                      return Text('No matching suggestions found.');
                    }
                  },
                ),

                SizedBox(height: 16),

                Text(
                  'Events near you:',
                  textAlign: TextAlign.center,
                  style: AppTextTheme.fallback().smallerTitle,
                ),

                SizedBox(height: 16),

                FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchEventsNearUser(),
                  builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Wrap(
                        spacing: 16.0,
                        runSpacing: 16.0,
                        children: List.generate(snapshot.data!.length, (index) {
                          String eventName = snapshot.data![index]['eventName'] as String;

                          return Dismissible(
                            key: Key(eventName),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              _dismissEventDetails();
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: SuggestionCard(
                              text: eventName,
                              color: getRandomColor(),
                              xPosition: index % 2 * 150.0,
                              yPosition: (index ~/ 2) * 120.0,
                              onSelectionChanged: (isSelected) {
                                setState(() {
                                  if (isSelected) {
                                    selectedSuggestions.add(eventName);
                                    saveSelectedSuggestions(); //edw
                                  } else {
                                    selectedSuggestions.remove(eventName);
                                    saveSelectedSuggestions(); //edw
                                  }
                                });
                              },
                              initiallySelected: selectedSuggestions.contains(eventName),
                              isEvent: true,
                              onDoubleTap: () {
                                // Add the event to mylist if it's not already there
                                showEventDetailsDialog(
  eventName: snapshot.data![index]['eventName'] as String,
  eventThemeAndRules: snapshot.data![index]['eventThemeAndRules'] as String,
  eventWhen: snapshot.data![index]['eventWhen'] as String,
  eventWhere: snapshot.data![index]['eventWhere'] as GeoPoint,
  userId: userId, //edw
);
                              }
                            ),
                          );
                        }),
                      );
                    } else {
                      return Text('No events found near you.');
                    }
                  },
                ),

                SizedBox(height: 16),

                WheelButton(
                  onPressed: (selectedSuggestions.length >= 2 && selectedSuggestions.length <= 6)
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyFortuneWheel(
                                userId: widget.userId,
                                selectedSuggestions: selectedSuggestions,
                              ),
                            ),
                          );
                        }
                      : null,
                ),

                SizedBox(height: 16),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: QuestionMarkButton2(
    onTapCallback: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InformationOnSuggestions(userId: userId)),
      );
    },
  ),
          ),
        ],
      ),
    );
  }


  Future<List<String>> fetchMatchingSuggestions() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
      Map<String, dynamic> userPreferences = userSnapshot.data() as Map<String, dynamic>;
      print('User Preferences: $userPreferences');

      List<QuerySnapshot> queryResults = await Future.wait([
        FirebaseFirestore.instance.collection('Suggestions').where('Mood', arrayContains: userPreferences['Mood']).get(),
        FirebaseFirestore.instance.collection('Suggestions').where('Budget', arrayContains: userPreferences['Budget']).get(),
        FirebaseFirestore.instance.collection('Suggestions').where('Interest', arrayContains: userPreferences['Interest']).get(),
        FirebaseFirestore.instance.collection('Suggestions').where('InOut', arrayContains: userPreferences['InOut']).get(),
        FirebaseFirestore.instance.collection('Suggestions').where('People', arrayContains: userPreferences['People']).get(),
      ]);

      Set<String> matchingSuggestions = {};

      for (QuerySnapshot result in queryResults) {
        for (QueryDocumentSnapshot doc in result.docs) {
          matchingSuggestions.add(doc['Activity'] as String);
        }
      }

      return matchingSuggestions.toList();
    } catch (error) {
      print('Error fetching suggestions: $error');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchEventsNearUser() async {
    try {
      // Get the user's location
      Position userLocation = await _getCurrentLocation();

      // Fetch events within a 20km radius of the user's location
      QuerySnapshot eventsSnapshot = await FirebaseFirestore.instance
          .collection('events')
          .where(
        'eventWhere',
        isGreaterThanOrEqualTo: GeoPoint(
          userLocation.latitude - 0.18,
          userLocation.longitude - 0.18,
        ),
      )
          .where(
        'eventWhere',
        isLessThanOrEqualTo: GeoPoint(
          userLocation.latitude + 0.18,
          userLocation.longitude + 0.18,
        ),
      )
          .get();

      // Extract event data
      List<Map<String, dynamic>> events = eventsSnapshot.docs.map((eventDoc) {
        return {
          'eventName': eventDoc['eventName'],
          'eventThemeAndRules': eventDoc['eventThemeAndRules'],
          'eventWhen': eventDoc['eventWhen'],
          'eventWhere': eventDoc['eventWhere'],
        };
      }).toList();

      return events;
    } catch (error) {
      print('Error fetching events near user: $error');
      return [];
    }
  }

  Future<Position> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      print("Error getting user's location: $e");
      throw e; // Rethrow the error to be caught by the calling function
    }
  }
  Future<void> _dismissEventDetails() async {
    Navigator.of(context).pop(); // Dismiss the event details dialog
  }
void showEventDetailsDialog({
  required String eventName,
  required String eventThemeAndRules,
  required String eventWhen,
  required GeoPoint eventWhere, 
  required String userId, //edw
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return YourInfoWindow(
        eventName: eventName,
        eventThemeAndRules: eventThemeAndRules,
        eventWhen: eventWhen,
        eventWhere: eventWhere,
        userId: userId, //edw
        onDismiss: () {
          _dismissEventDetails(); // Pass the dismiss function to YourInfoWindow
        },
      );
    },
  );
}

}
