import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/colors/app_color_themes.dart';
import '/text/app_text_themes.dart';
import '/widgets/custom_text_input.dart';
import '/widgets/continue_button.dart';
import '/screens/profile.dart';
import '/screens/info_on_add_your_event.dart';
import '/widgets/question_mark_button_2.dart';

class AddYourEvent extends StatefulWidget {
  final String userId;

  AddYourEvent({required this.userId});

  @override
  _AddYourEventState createState() => _AddYourEventState();
}

class _AddYourEventState extends State<AddYourEvent> {
  String? eventName;
  Position? _userLocation;
  String? eventWhen;
  String? eventThemeAndRules;

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventWhenController = TextEditingController();
  TextEditingController eventThemeAndRulesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backround,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 69),
                  SizedBox(
                    height: 76,
                    child: Center(
                      child: Text(
                        'Add your event',
                        style: AppTextTheme.fallback().smallerTitle?.copyWith(color: Colors.white) ??
                            TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  CustomTextInput(
                    labelText: 'Event name',
                    controller: eventNameController,
                    top: 20,
                    labelStyle: AppTextTheme.fallback().basicText ?? TextStyle(),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    'Location: ${_userLocation != null ? "${_userLocation!.latitude}, ${_userLocation!.longitude}" : "Loading..."}',
                    style: AppTextTheme.fallback().basicText ?? TextStyle(),
                  ),

                  const SizedBox(height: 10),

                  CustomTextInput(
                    labelText: 'When',
                    controller: eventWhenController,
                    top: 20,
                    labelStyle: AppTextTheme.fallback().basicText ?? TextStyle(),
                  ),
                  const SizedBox(height: 10),

                  CustomTextInput(
                    labelText: 'Theme & Rules',
                    controller: eventThemeAndRulesController,
                    top: 20,
                    labelStyle: AppTextTheme.fallback().basicText ?? TextStyle(),
                  ),

                  SizedBox(height: 25),

                  // Continue Button
                  ContinueButton(
                    onPressed: () async {
                      print('ContinueButton pressed');
                      saveEventName();
                      saveEventWhen();
                      saveEventThemeAndRules();

                      await _getCurrentLocation();
                      await _saveEventToFirestore();

                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage(userId: widget.userId)),
                      );
                    },
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: QuestionMarkButton2(
              onTapCallback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InformationOnAddYourEvent(userId: widget.userId)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void saveEventName() {
    setState(() {
      eventName = eventNameController.text;
    });
  }

  void saveEventWhen() {
    setState(() {
      eventWhen = eventWhenController.text;
    });
  }

  void saveEventThemeAndRules() {
    setState(() {
      eventThemeAndRules = eventThemeAndRulesController.text;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _userLocation = position;
      });
    } catch (e) {
      print("Error getting user's location: $e");
      // Handle error gracefully
    }
  }

  Future<void> _saveEventToFirestore() async {
    try {
      if (mounted) {
        // Check if the widget is still mounted
        // Get a reference to the Firestore collection
        CollectionReference eventsCollection = FirebaseFirestore.instance.collection('events');

        // Create a new document with a unique ID
        DocumentReference newEventRef = await eventsCollection.add({
          'eventName': eventName,
          'eventWhere': _userLocation != null ? GeoPoint(_userLocation!.latitude, _userLocation!.longitude) : null,
          'eventWhen': eventWhen,
          'eventThemeAndRules': eventThemeAndRules,
        });

        print('Event saved to Firestore with ID: ${newEventRef.id}');
      }
    } catch (e) {
      print('Error saving event to Firestore: $e');
      // Handle error gracefully
    }
  }
}
