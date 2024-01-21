import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/colors/app_color_themes.dart';
import '/widgets/custom_text_input.dart';
import '/widgets/profile_picture.dart';
import '/widgets/save_button.dart';
import '/text/app_text_themes.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '/widgets/email_error_custom_text_input.dart';
import '/screens/profile.dart';
import 'dart:typed_data';

class EditProfile extends StatefulWidget {
  final String userId;

  EditProfile({required this.userId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _selectedImagePath;
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _fetchUserData(); 
  }

  bool _isEmailValid(String email) {
    String emailRegex =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // Regular expression to validate email format
    return RegExp(emailRegex).hasMatch(email);
  }

  bool showEmailError = false;
  bool showIncompleteFormMessage = false;


  bool _areAllFieldsFilled() {
    return 
        _nameController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        selectedDate != null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        showEmailError = true; // Set showEmailError if the field is empty
      });
      return 'Please enter an email';
    } else if (!_isEmailValid(value)) {
      setState(() {
        showEmailError = true; // Set showEmailError if the email format is invalid
      });
      return 'Invalid email format';
    } else {
      setState(() {
        showEmailError = false; // Reset showEmailError if the email is valid
      });
      return null;
    }
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();

      setState(() {
        _nameController.text = userData['Name'];
        _phoneNumberController.text = userData['Phone Number'];
        _emailController.text = userData['Email'];
        Timestamp timestamp = userData['DateOfBirth'];
        if (timestamp != null) {
          selectedDate = timestamp.toDate();
        }
      });
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {

void _saveUserData() async {
  if (_formKey.currentState!.validate()) {
    print("valid form");
    String updatedName = _nameController.text;
    String updatedPhoneNumber = _phoneNumberController.text;
    String updatedEmail = _emailController.text;

    if (!_isEmailValid(updatedEmail)) {
      setState(() {
        showEmailError = true; // Set showEmailError to true if email is invalid
      });
      print('Please enter a valid email');
      return;
    } else {
      setState(() {
        showEmailError = false; // Reset showEmailError if the email is valid
      });
    }

    if (!_areAllFieldsFilled()) {
      setState(() {
        showIncompleteFormMessage = true; // Set showEmailError to true if email is invalid
      });
      print('Please fill everything');
      return;
    } else {
      setState(() {
        showIncompleteFormMessage = false; // Reset showEmailError if the email is valid
      });
    }

    if (
        updatedName.isEmpty ||
        updatedPhoneNumber.isEmpty ||
        updatedEmail.isEmpty ) {
      setState(() {
        showIncompleteFormMessage = true;
      });
      // Show an error message or prevent saving if any field is empty
      print('Please fill in all fields');
      return;
    }

    try {
// Update the user's fields in Firebase (excluding Username)
          await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
            'Name': updatedName,
            'Phone Number': updatedPhoneNumber,
            'Email': updatedEmail,
            'DateOfBirth': Timestamp.fromDate(selectedDate),
          });

          await _uploadImageToFirebaseStorage();

          // Navigate back to the profile page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage(userId: widget.userId)),
          );

        } catch (error) {
          print('Failed to save user data to Firestore: $error');
        }
      } else {
        setState(() {
          showEmailError = true;
          print('test');
          //showIncompleteFormMessage = true;
        });
      }
    }

    return Scaffold(
      backgroundColor: AppColors.backround,
      body: Form( 
        key: _formKey,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showIncompleteFormMessage)
      SizedBox(height: 20),
      if (showIncompleteFormMessage)
        Container(
          width: 360,
          height: 48,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 360,
                height: 48,
                padding: const EdgeInsets.only(left: 16),
                decoration: ShapeDecoration(
                  color: Color(0xFFEB5757),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x4C000000),
                      blurRadius: 3,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: SizedBox(
                        height: 22,
                        child: Text(
                          'Please fill in all the boxes correclty!',
                          style: TextStyle(
                            color: Color(0xFF261B34),
                            fontSize: 16,
                            fontFamily: 'Fugaz One',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        child: const Stack(
                                          children: [
                                            // Add your icon or content here
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        
         if (!showIncompleteFormMessage) 
          SizedBox(height: 69),
              SizedBox(height: 69),
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
    Column(
      children: [
        ProfilePicture(imageUrl: _selectedImagePath ?? "https://via.placeholder.com/112x112"),
        SizedBox(height: 8),
        InkWell(
          onTap: () {
            _showImagePicker(context);
          },
          child: Text(
            'Change Photo',
            style: AppTextTheme.fallback().underlinedBasicText?.copyWith(color: Colors.white) ??
                TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
              SizedBox(height: 20),
              CustomTextInput(
                labelText: 'Name',
                controller: _nameController,
                top: 20,
                labelStyle: AppTextTheme.fallback().basicText ?? TextStyle(),
              ),
              SizedBox(height: 15),
              CustomTextInput(
                labelText: 'Phone Number',
                controller: _phoneNumberController,
                top: 20,
                labelStyle: AppTextTheme.fallback().basicText ?? TextStyle(),
              ),
              SizedBox(height: 15),
              EmailCustomTextInput(
                  labelText: 'Email',
                  controller: _emailController,
                  top: 20,
                  labelStyle: AppTextTheme.fallback()?.basicText ?? TextStyle(),
                  showError: showEmailError, 
                  validator: validateEmail, 
                ),
              SizedBox(height: 15),
              Container(
                width: 347,
                height: 106,
                child: GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != selectedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        left: 24,
                        top: 0,
                        child: Container(
                          width: 289,
                          height: 34,
                          padding: const EdgeInsets.only(
                              left: 0.06, right: 0.12, bottom: 0.14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 284.94,
                                height: 30,
                                child: Text(
                                  'Date of Birth',
                                  style: AppTextTheme.fallback().basicText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 20,
                        child: Container(
                          width: 347,
                          height: 82,
                          padding: const EdgeInsets.only(
                              top: 18, left: 24, right: 24, bottom: 16),
                          child: Container(
                            width: double.infinity,
                            height: 48,
                            padding:
                                const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.backround,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                selectedDate != null
                                    ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                                    : 'Select your birthdate',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.50,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: (showEmailError || !_areAllFieldsFilled())
                  ? () {
                      setState(() {
                        showIncompleteFormMessage = true;
                      });
                      _saveUserData();
                    }
                  : () {
                      _saveUserData();
                    },
                child: Container(
                  width: 129,
                  height: 47,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 2.32,
                        top: 0,
                        child: Container(
                          width: 125.51,
                          height: 47,
                          decoration: ShapeDecoration(
                            color: AppColors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 6,
                        child: SizedBox(
                          width: 129,
                          height: 28,
                          child: Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.699999988079071),
                              fontSize: 23,
                              fontFamily: 'Fugaz One',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              SizedBox(height: 50),

            ],
          ),
        ),
        ),
      ),
    );
  }
/*
  Future<void> _showImagePicker(BuildContext context) async {
    final picker = ImagePicker();
    final imageSource = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        );
      },
    );

    if (imageSource != null) {
      final pickedFile = await picker.pickImage(source: imageSource);

      if (pickedFile != null) {
        _selectedImagePath = pickedFile.path;
        setState(() {});
      }
    }
  }*/

  Future<void> _showImagePicker(BuildContext context) async {
  final picker = ImagePicker();
  final imageSource = await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from gallery'),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Take a photo'),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
        ],
      );
    },
  );

  if (imageSource != null) {
    final pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      _selectedImagePath = pickedFile.path;
      setState(() {});
    }
  }
}

/*
Future<void> _uploadImageToFirebaseStorage() async {
  if (_selectedImagePath != null) {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance.ref().child('profile_pictures/${widget.userId}');
      final File imageFile = File(_selectedImagePath!);

      // Read the file as bytes
      final List<int> imageBytes = await imageFile.readAsBytes();

      // Upload the bytes to Firebase Storage
      await storageRef.putData(Uint8List.fromList(imageBytes));

      // Get the download URL for the uploaded file
      final downloadURL = await storageRef.getDownloadURL();

      // Update the user's 'ProfilePicture' field in Firestore with the download URL
      await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
        'ProfilePicture': downloadURL,
      });
    } catch (error) {
      print('Error uploading image: $error');
    }
  }
}*/

Future<void> _uploadImageToFirebaseStorage() async {
  if (_selectedImagePath != null) {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance.ref();
      final fileName = path.basename(_selectedImagePath!);
      final uploadRef = storageRef.child('profile_pictures/${widget.userId}/$fileName');

      await uploadRef.putFile(File(_selectedImagePath!));

      final downloadURL = await uploadRef.getDownloadURL();

      // Update the user's 'ProfilePicture' field in Firestore with the download URL
      await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
        'ProfilePicture': downloadURL,
      });
    } catch (error) {
      print('Error uploading image: $error');
    }
  } else {
    print('Selected image path is null');
  }
}

}
