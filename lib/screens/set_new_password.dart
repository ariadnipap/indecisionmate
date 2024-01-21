import 'package:flutter/material.dart';
import '/widgets/in_out.dart';
import '/screens/profile.dart';
import '/text/app_text_themes.dart';
import '/colors/app_color_themes.dart';
import '/widgets/custom_text_input.dart';
import '/text/app_text_themes.dart';

class SetNewPassword extends StatefulWidget {
  @override
  _SetNewPasswordState createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backround,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 69),

              SizedBox(
                width: 238,
                height: 100,
                child: Text(
                  'Set your new password:',
                  textAlign: TextAlign.center,
                  style: AppTextTheme.fallback().smallerTitle,
                ),
              ),
              SizedBox(height: 30),

              CustomTextInput(
                labelText: 'Old password',
                controller: oldPasswordController,
                top: 20,
                labelStyle: AppTextTheme.fallback().basicText ?? TextStyle(),
              ),
              SizedBox(height: 15),
              CustomTextInput(
                labelText: 'New password',
                controller: newPasswordController,
                top: 20,
                labelStyle: AppTextTheme.fallback().basicText ?? TextStyle(),
              ),
              SizedBox(height: 15),
              CustomTextInput(
                labelText: 'Confirm new password',
                controller: confirmNewPasswordController,
                top: 20,
                labelStyle: AppTextTheme.fallback().basicText ?? TextStyle(),
              ),
              SizedBox(height: 20),

              // InOutWidget with green color, "Set" label, and navigation to MyProfile
              InOutWidget(
                text: 'Set',
                color: AppColors.green, // Set color to green
                onPressed: () {
                  // Save the values from the three text inputs to Firebase or wherever needed
                  String oldPassword = oldPasswordController.text;
                  String newPassword = newPasswordController.text;
                  String confirmNewPassword = confirmNewPasswordController.text;

                  // Add your logic to handle the button press
                  // Navigate to MyProfile page or perform other actions
                 /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyProfile()),
                  ); */
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveOldPassword(String old_password) {
    setState(() {
      oldPassword = old_password;
    });
  }

  void saveNewPassword(String new_password) {
    setState(() {
      newPassword = new_password;
    });
  }

  void saveConfirmNewPassword(String confirm_new_password) {
    setState(() {
      confirmNewPassword = confirm_new_password;
    });
  }
}
