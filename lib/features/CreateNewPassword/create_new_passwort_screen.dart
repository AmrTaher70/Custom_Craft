import 'package:custom_craft/api/change_password_model.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/text_filed_data.dart';
import 'package:custom_craft/features/Profile/profile.dart';
import 'package:custom_craft/features/home/home_screen.dart';
import 'package:custom_craft/helper/api.helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

TextEditingController newPasswordController = TextEditingController();
// TextEditingController userNameController = TextEditingController();
TextEditingController previousPasswordController = TextEditingController();
TextEditingController confirmNewPasswordController = TextEditingController();
bool _showPassword = false;
final formKey = GlobalKey<FormState>();
bool isLoading = false;
Api api = Api();

Future<void> changePassword(BuildContext context) async {
  try {
    // Validate the form
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Retrieve token
    String? token = api.getToken();
    print('Token: $token'); // Debug print to check token value

    // Check if token is available
    // if (token == null) {
    //   throw Exception('Token not available');
    // }

    // Create an instance of ChangePasswordModel using user input
    ChangePasswordModel changePasswordData = ChangePasswordModel(
      confirmPassword: confirmNewPasswordController.text,
      currentPassword: previousPasswordController.text,
      newPassword: newPasswordController.text,
    );

    // Convert ChangePasswordModel to JSON
    Map<String, dynamic> changePasswordJson = changePasswordData.toJson();

    // Make API call to change password
    dynamic response = await api.put(
      url: 'http://customcraftt.somee.com/api/Account/ChangePassword',
      body: changePasswordJson,
      token: token, // Pass the token in the request headers
    );

    // Check if the response indicates success
    if (response['success'] == true) {
      // Handle success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Change Password successful'),
        ),
      );

      // Navigate to desired screen
      // ...
    } else {
      // Handle API error responses
      throw Exception(response['message']);
    }
  } catch (e) {
    // Handle any exceptions
    print('Error changing password: $e');
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An error occurred: $e'),
      ),
    );
  }
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                          Get.to(
                            () => const Profile(),
                          );
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
                        height: 16,
                      ),
                      Image.asset(
                        AssetsData.createNewPassword,
                        height: 251,
                        width: 232,
                      ),
                      const SizedBox(
                        height: 16,
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
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: TextFiledData(
                      //     labelText: 'User Name',
                      //     controller: userNameController,
                      //     suffixIcon: IconButton(
                      //       onPressed: () {},
                      //       icon: const Icon(Icons.person_2_outlined),
                      //     ),
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return 'Username is required';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFiledData(
                          labelText: 'current Password',
                          controller: previousPasswordController,
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
                          obscureText: !_showPassword,
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
                          labelText: 'New Password',
                          controller: newPasswordController,
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
                          obscureText: !_showPassword,
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
                          controller: confirmNewPasswordController,
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
                          obscureText: !_showPassword,
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
                                await changePassword(context);
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //     content:
                                //         Text('Change Password successfully'),
                                //   ),
                                // );

                                // Navigate to sign-in screen if sign-up succeeds
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           const LoginScreen()),
                                // );
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
                        padding: const EdgeInsets.only(top: 49, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Go Back to',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => const HomeScreen(),
                                    transition: Transition.fadeIn);
                              },
                              child: const Text(
                                'Home Page',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
