import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/colors/app_color_themes.dart';
import '/widgets/suggestion.dart';
import '/text/app_text_themes.dart';
import '/widgets/question_mark_button_2.dart';
import '/screens/info_on_my_list.dart';

class MyList extends StatefulWidget {
  final String userId;

  MyList({Key? key, required this.userId}) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
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

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.backround,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'My List',
              textAlign: TextAlign.center,
              style: AppTextTheme.fallback().title?.copyWith(color: Colors.white),
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
                    width: 280,
                    height: 100,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Your picks:',
                              style: AppTextTheme.fallback().smallerTitle?.copyWith(color: Colors.white)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(widget.userId).get(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.exists) {
                  List<String> mylist = List<String>.from(snapshot.data!['mylist']);

                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemCount: mylist.length,
                    itemBuilder: (context, index) {
                      String suggestion = mylist[index];

                      return SuggestionCard(
                        text: suggestion,
                        color: getRandomColor(),
                        xPosition: index % 2 * 150.0,
                        yPosition: (index ~/ 2) * 120.0,
                        onSelectionChanged: (isSelected) async {
                          if (isSelected) {
                            // Remove the suggestion from mylist if it's selected
                            setState(() {
                              mylist.remove(suggestion);
                            });

                            // Update mylist field in the users collection
                            await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
                              'mylist': mylist,
                            });
                          }
                        },
                        initiallySelected: false,
                      );
                    },
                  );
                } else {
                  return Text('No data found.');
                }
              },
            ),

            SizedBox(height: 16),
                      Positioned(
            top: 20,
            right: 20,
            child: QuestionMarkButton2(
    onTapCallback: () {
      Navigator.push(
        context,
  MaterialPageRoute(builder: (context) => ParentWidget(userId: widget.userId)),
      );
    },
  ),
          ),
          ],
        ),
      ),
    );
  }
}
