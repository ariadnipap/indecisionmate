import 'package:flutter/material.dart';
import '/colors/app_color_themes.dart';
import '/widgets/custom_text_input.dart';
import '/text/app_text_themes.dart';
import '/screens/choose_your_interests.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import '/widgets/error_message_custom_text_input.dart';
import '/widgets/email_error_custom_text_input.dart';
import '../widgets/password_custom_text_input.dart';
import '/widgets/confirm_password_custom_input_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget { // Change from StatelessWidget to StatefulWidget
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> { // Create a State class for SignUpPage
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  DateTime? selectedDate; // Store selected date
  late String userId;
  final _formKey = GlobalKey<FormState>(); // GlobalKey for the Form widget

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    
    @override
      void dispose() {
        // Dispose the TextEditingControllers when the widget is disposed
        usernameController.dispose();
        passwordController.dispose();
        confirmPasswordController.dispose();
        nameController.dispose();
        phoneNumberController.dispose();
        emailController.dispose();
        super.dispose();
      }

  // Function to validate email format using RegExp
  bool _isEmailValid(String email) {
    String emailRegex =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // Regular expression to validate email format
    return RegExp(emailRegex).hasMatch(email);
  }

  // Function to validate password complexity
  bool _isPasswordValid(String password) {
    String passwordRegex =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
    return RegExp(passwordRegex).hasMatch(password);
  }

  // Function to check if the username already exists in Firestore
  Future<bool> _isUsernameUnique(String username) async {
    QuerySnapshot query =
        await users.where('Username', isEqualTo: username).get();
    return query.docs.isEmpty; // True if username doesn't exist, otherwise false
  }

  bool showError = false; // Define showError within the state
  bool showEmailError = false;
  bool showPasswordError = false;
  bool showConfirmPasswordError =false;
  bool showIncompleteFormMessage = false;

  bool _areAllFieldsFilled() {
    return usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        showPasswordError = true; // Set showEmailError if the field is empty
      });
      return 'Please enter a Password';
    } else if (!_isPasswordValid(value)) {
      setState(() {
        showPasswordError = true; // Set showEmailError if the email format is invalid
      });
      return 'Password should have at least 8 characters '
            'and include a letter, a number, and a symbol.';
    } else {
      setState(() {
        showPasswordError = false; // Reset showEmailError if the email is valid
      });
      return null;
    }
  }

  String? passwordsMatchValidator(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        showConfirmPasswordError = true; // Set showEmailError if the field is empty
      });
      return 'Please enter your Password';
    } else if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        showConfirmPasswordError = true; // Set showEmailError if the email format is invalid
      });
    return 'Passwords do not match';
    }
    else {
      setState(() {
        showConfirmPasswordError = false; // Reset showEmailError if the email is valid
      });
    return null;
     } // Return null if passwords match
  }

  @override
  Widget build(BuildContext context) {

void _saveUserData() async {
  if (_formKey.currentState!.validate()) {
    String username = usernameController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String name = nameController.text;
    String phoneNumber = phoneNumberController.text;
    String email = emailController.text;

    if (!_isEmailValid(email)) {
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

    if (username.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        name.isEmpty ||
        phoneNumber.isEmpty ||
        email.isEmpty ||
        showError ||
        showEmailError ||
        showPasswordError ||
        showConfirmPasswordError ||
        selectedDate == null) {
      // Show an error message or prevent saving if any field is empty
      print('Please fill in all fields including the Date of Birth');
      return;
    }

    if (password != confirmPassword) {
      // Validate if password matches confirm password
      print('Passwords do not match');
      return;
    }

    if (password.length < 8 || !_isPasswordValid(password)) {
      // Validate password complexity
      print('Password should have at least 8 characters '
          'and include a letter, a number, and a symbol.');
      return;
    }

    if (!_isEmailValid(email)) {
      // Validate email format
      print('Please enter a valid email');
      return;
    }

    try {
      // Use Firebase authentication to create a user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: '$username@yourdomain.com',
        password: password,
      );

      userId = userCredential.user?.uid ?? '';

      // Combine all the user data into a single map
      Map<String, dynamic> userData = {
        'Username': username,
        'Password': password,
        'Confirm Password': confirmPassword,
        'Name': name,
        'Phone Number': phoneNumber,
        'Email': email,
        'DateOfBirth': selectedDate,
      };

      // Save the combined user data into Firestore
      users.doc(userId).set(userData).then((_) {
        print('User data saved to Firestore');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChooseYourInterestsPage(userId: userId),
          ),
        ).then((_) {
          setState(() {
            // Handle any state changes or updates after navigating back from ChooseYourInterestsPage.
          });
        });
      }).catchError((error) {
        print('Failed to save user data to Firestore: $error');
      });
    } catch (error) {
      print('Failed to create user: $error');
    }
  } else {
    setState(() {
      // Set showError and showEmailError based on form validation
      showError = true;
      showEmailError = true;
      showPasswordError = true;
      showConfirmPasswordError = true;
    });
  }
}


return Scaffold(
  backgroundColor: AppColors.backround,
  body: SingleChildScrollView(
    child: Center(
      child: Form(
            key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 69),
          SizedBox(
            width: 238,
            height: 45,
            child: Text(
              'Sign up to your',
              textAlign: TextAlign.center,
              style: AppTextTheme.fallback().smallerTitle),
          ),
          Container(
            width: 400,
            height: 54,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 44,
                  height: 43,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Image.asset('assets/logo2.png'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 302,
                  height: 64,
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
          ),

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
                      Expanded(
                        child: SizedBox(
                          height: 20,
                          child: Text(
                            'Please fill in all the boxes!',
                            style: TextStyle(
                              color: Color(0xFF261B34),
                              fontSize: 18,
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
                                          child: Stack(
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

          SizedBox(height: 30),
                    ErrorCustomTextInput(
                      labelText: 'Username',
                      controller: usernameController,
                      top: 20,
                      labelStyle: AppTextTheme.fallback()?.basicText ?? TextStyle(),
                      showError: showError, // Pass showError to CustomTextInput
                      validator: (value) {
                        if (value.isNotEmpty) {
                          _isUsernameUnique(value).then((isUnique) {
                            setState(() {
                              // Set showError based on the uniqueness of the username
                              showError = !isUnique;
                            });
                          });
                        }
                        return false; // Initially set showError to false
                      },
                    ),

              PasswordCustomTextInput(
                  labelText: 'Password',
                  controller: passwordController,
                  top: 20,
                  labelStyle: AppTextTheme.fallback()?.basicText ?? TextStyle(),
                  showError: showPasswordError, // Pass showError state to the EmailCustomTextInput
                  validator: validatePassword, // Pass the validator function
                ),
               SizedBox(height: 15),

              ConfirmPasswordCustomTextInput(
                  labelText: 'Confirm Password',
                  controller: confirmPasswordController,
                  top: 20,
                  labelStyle: AppTextTheme.fallback().basicText ?? TextStyle(),
                  showError: showConfirmPasswordError, // Pass showError state to the EmailCustomTextInput
                  validator: passwordsMatchValidator, // Pass the validator function
                ),

               SizedBox(height: 15),
              CustomTextInput(
                labelText: 'Name',
                controller: nameController,
                top: 20,
                labelStyle: AppTextTheme.fallback()?.basicText ?? TextStyle(),
                
              ),
               SizedBox(height: 15),
              CustomTextInput(
                labelText: 'Phone number',
                controller: phoneNumberController,
                top: 20,
                labelStyle: AppTextTheme.fallback()?.basicText ?? TextStyle(),
                
              ),
               SizedBox(height: 15),
               EmailCustomTextInput(
                  labelText: 'Email',
                  controller: emailController,
                  top: 20,
                  labelStyle: AppTextTheme.fallback()?.basicText ?? TextStyle(),
                  showError: showEmailError, // Pass showError state to the EmailCustomTextInput
                  validator: validateEmail, // Pass the validator function
                ),

                SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 347,
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text(
                          'Date of Birth',
                          style: AppTextTheme.fallback().basicText,
                        ),
                      ),
                    ),
                    Container(
                      width: 347,
                      height: 82,
                      padding: const EdgeInsets.only(top: 8, left: 24, right: 24, bottom: 16),
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.backround,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate ?? DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null && pickedDate != selectedDate) {
                                setState(() {
                                  selectedDate = pickedDate;
                                });
                              }
                            },
                            child: Text(
                              selectedDate != null
                                  ? '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}'
                                  : 'Select your birthdate', // Display default text if date not selected
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



               InkWell(
              onTap: (showError || showEmailError || showConfirmPasswordError || showPasswordError || selectedDate == null || !_areAllFieldsFilled())
                  ? () {
                      setState(() {
                        showIncompleteFormMessage = true;
                      });
                    }
                  : _saveUserData,
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
                            color: Color(0xFCD42AFF),
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
                            'Continue',
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
      )
          ),
        ),
      ),
    );
  }
}