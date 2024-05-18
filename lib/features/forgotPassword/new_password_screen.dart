import 'dart:convert';

import 'package:custom_craft/api/change_password_model.dart';
import 'package:custom_craft/api/reset_password_model/reset_password_model.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/text_filed_data.dart';
import 'package:custom_craft/features/Contact%20US/contact_us_screen.dart';
import 'package:custom_craft/features/forgotPassword/forgot_password_screen.dart';
import 'package:custom_craft/features/forgotPassword/verify_email_screen.dart';
import 'package:custom_craft/features/login/login_screen.dart';
import 'package:custom_craft/helper/api.helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewPasswordScreen extends StatefulWidget {
  final String? forgotemail;
  const NewPasswordScreen({
    Key? key,
    this.forgotemail,
  }) : super(key: key); // 'super' should be used here

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

final TextEditingController _newPasswordController = TextEditingController();
final TextEditingController _confirmNewPasswordController =
    TextEditingController();
bool _showPassword = false;
final formKey = GlobalKey<FormState>();
bool isLoading = false;
Api api = Api();
String? forgottenEmail;

Future<void> resetPassword(
  BuildContext context,
) async {
  try {
    // Validate the form
    if (!formKey.currentState!.validate()) {
      return;
    }
    String? token = await api.getToken();
    print('Token: $token');
    print(forgottenEmail);
    // Create an instance of ChangePasswordModel using user input
    ResetPasswordModel resetPasswordData = ResetPasswordModel(
      confirmPassword: _confirmNewPasswordController.text,
      newPassword: _newPasswordController.text,
      email: forgottenEmail,
      token: token,
    );

    // Convert ChangePasswordModel to JSON
    Map<String, dynamic> resetPasswordJson = resetPasswordData.toJson();

    // Make API call to change password
    http.Response response = await api.post(
      url: 'http://customcrafttt.somee.com/api/Account/ResetPassword',
      body: resetPasswordJson,
    );

    // Check if the response is successful
    if (response.statusCode == 200) {
      try {
        // Try to parse the response as JSON
        print('reset password successful: $response');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reset Password successful'),
          ),
        );

        // Navigate to profile screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } catch (e) {
        // Handle FormatException for non-JSON response
        if (e is FormatException &&
            response.body.contains("Password Changed")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Change Password successful'),
            ),
          );

          // Navigate to profile screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          // Rethrow other exceptions
          rethrow;
        }
      }
    } else {
      throw Exception(
          'There is a problem with the status code ${response.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions
    print('Error changing password: $e');
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Change Password successful'),
      ),
    );

    // Navigate to profile screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  @override
  void initState() {
    super.initState();
    // Load forgotten email when the screen initializes
    _loadForgottenEmail();
  }

  // Function to load forgotten email from shared preferences
  Future<void> _loadForgottenEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      forgottenEmail = prefs.getString('forget_email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 24),
                child: Stack(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xffFAFAFA).withOpacity(.7),
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.to(() => const VerifyEmailScreen(),
                            transition: Transition.fadeIn);
                      },
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: AssetsColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Create New Password',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 64,
                      ),
                      Image.asset(
                        AssetsData.newPassword,
                        height: 187,
                        width: 187,
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      const Center(
                        child: Text(
                          'Your new password must be different from previously used password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8E8E8E),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFiledData(
                          labelText: 'New Password',
                          controller: _newPasswordController,
                          obscureText: !_showPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            } else if (!value.contains(RegExp(r'[A-Z]'))) {
                              return 'Password must contain at least one capital letter';
                            } else if (!value
                                .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_]'))) {
                              return 'Password must contain at least one special character';
                            } else if (!value.contains(RegExp(r'[0-9]'))) {
                              return 'Password must contain at least one number';
                            }

                            return null; // Return null if validation succeeds
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: _showPassword
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFiledData(
                          labelText: 'Confirm Password',
                          controller: _confirmNewPasswordController,
                          obscureText: !_showPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            } else if (!value.contains(RegExp(r'[A-Z]'))) {
                              return 'Password must contain at least one capital letter';
                            } else if (!value
                                .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_]'))) {
                              return 'Password must contain at least one special character';
                            } else if (!value.contains(RegExp(r'[0-9]'))) {
                              return 'Password must contain at least one number';
                            }

                            return null; // Return null if validation succeeds
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: _showPassword
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: 359,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Validate the form
                            if (formKey.currentState!.validate()) {
                              try {
                                // Show loading indicator on the button
                                setState(() {
                                  isLoading = true;
                                });

                                // Attempt sign-up
                                await resetPassword(
                                  context,
                                );
                              } catch (e) {
                                // Hide loading indicator
                                setState(() {
                                  isLoading = false;
                                });

                                // Display debug message with error
                                debugPrint('Error during change password : $e');

                                // Show snackbar with error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'An error occurred. Please try again later.'),
                                  ),
                                );
                              } finally {
                                // Hide loading indicator after sign-up attempt is completed
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AssetsColors.primaryColor, // Background color
                            // foregroundColor:
                            //     Colors.white, // Text color
                            // Button padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  12), // Button border radius
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.w400, // Text weight
                            ),
                            elevation: 5, // Button elevation
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : const Text('Save'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 109, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Go Back to',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => const LoginScreen(),
                                    transition: Transition.fadeIn);
                              },
                              child: const Text(
                                'Log In Page',
                                style: TextStyle(
                                  color: AssetsColors.primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
