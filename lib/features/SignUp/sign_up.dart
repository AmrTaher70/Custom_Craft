import 'dart:ui';

import 'package:custom_craft/api/sign_up_model.dart';
import 'package:custom_craft/constans/app_string/app_string.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/text_filed_data.dart';
import 'package:custom_craft/features/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:universal_html/js.dart';

import '../../helper/api.helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  bool _showPassword = false;
  Api api = Api();

// Function to handle sign-up
  Future<bool> signUp(BuildContext context) async {
    try {
      // Create an instance of SignUpModel using user input
      SignUpModel signUpData = SignUpModel(
        userName: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      // Convert SignUpModel to JSON
      Map<String, dynamic> signUpJson = signUpData.toJson();

      // Make API call to sign up
      dynamic response = await api.post(
        url: 'http://customcrafttt.somee.com/api/Account/register',
        body: signUpJson,
      );

      // Handle successful response
      print('Sign up successful: $response');
      return true;
    } catch (e) {
      // Handle any exceptions
      print('Error signing up: $e');

      // Check for specific error messages and provide feedback to the user
      final errorMessage = e.toString();

      if (errorMessage
          .contains('This UserName is already taken try another one')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('This UserName is already taken try another one'),
          ),
        );
      } else if (errorMessage.contains('This email is already in use!')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('This email is already in use! Please try another one.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again later.'),
          ),
        );
      }

      return false;
    } finally {
      // Hide loading indicator
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final screenSize = MediaQuery.of(context).size;
        final double width = screenSize.width;
        final double h = screenSize.height;

        return BackGroundImage(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 113, bottom: 60),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            height: 620,
                            width: width < 600 ? screenSize.width * 0.9 : 327,
                            decoration: BoxDecoration(
                              color: const Color(0xffFAFAFA).withOpacity(.4),
                              border: Border.all(
                                  color: const Color(0xffFCFCFC), width: 4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    AssetsData.logo,
                                    height: 59,
                                    width: 70,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width < 600
                                        ? 40
                                        : 80), // Adjust padding based on screen size
                                child: const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width < 600 ? 40 : width - 80),
                                child: TextFiledData(
                                  labelText: 'User Name',
                                  controller: userNameController,
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.person_2_outlined),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Username is required';
                                    }
                                    return null;
                                  },
                                  // Adding email icon
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: TextFiledData(
                                  labelText: 'Email',
                                  controller: emailController,
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.email_outlined),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email is required';
                                    } else if (!value.contains('@') ||
                                        !value.contains('.')) {
                                      return 'Invalid email format';
                                    }
                                    return null; // Return null if validation succeeds
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width < 600 ? 40 : width - 80),
                                child: TextFiledData(
                                  labelText: 'Password',
                                  controller: passwordController,
                                  obscureText: !_showPassword,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                    icon: _showPassword
                                        ? const Icon(Icons.visibility_outlined)
                                        : const Icon(
                                            Icons.visibility_off_outlined,
                                          ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    } else if (!value
                                        .contains(RegExp(r'[A-Z]'))) {
                                      return 'Password must contain at least one capital letter';
                                    } else if (!value.contains(
                                        RegExp(r'[!@#$%^&*(),.?":{}|<>_]'))) {
                                      return 'Password must contain at least one special character';
                                    } else if (!value
                                        .contains(RegExp(r'[0-9]'))) {
                                      return 'Password must contain at least one number';
                                    }

                                    return null; // Return null if validation succeeds
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width < 600 ? 40 : width - 80),
                                child: TextFiledData(
                                  labelText: 'Confirm Password',
                                  controller: confirmPasswordController,
                                  obscureText: !_showPassword,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                    icon: _showPassword
                                        ? const Icon(Icons.visibility_outlined)
                                        : const Icon(
                                            Icons.visibility_off_outlined,
                                          ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Confirm Password is required';
                                    } else if (value !=
                                        passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null; // Return null if validation succeeds
                                  },
                                ),
                              ),

                              const SizedBox(
                                height: 24,
                              ),
                              // Sign Up Button
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 45,
                                  width: 305,
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
                                          bool success = await signUp(context);

                                          // Show success dialog only if sign-up is successful
                                          if (success) {
                                            // ignore: use_build_context_synchronously
                                            showSuccessDialog(
                                                context, emailController.text);
                                          }

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
                                          debugPrint(
                                              'Error during sign-up: $e');

                                          // Show snackbar with error message
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
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
                                          AssetsColors.primaryColor,
                                      // Background color
                                      // foregroundColor:
                                      //     Colors.white, // Text color
                                      // Button padding
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // Button border radius
                                      ),
                                      textStyle: const TextStyle(
                                        fontSize: 18, // Text size
                                        fontWeight:
                                            FontWeight.w400, // Text weight
                                      ),
                                      elevation: 5, // Button elevation
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            ),
                                          )
                                        : const Text(AssetsStrings.appSignUp),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Container(
                              //       width: 90,
                              //       height: 2,
                              //       color: const Color(0xff8E8E8E),
                              //     ),
                              //     const Padding(
                              //       padding:
                              //           EdgeInsets.symmetric(horizontal: 5),
                              //       child: Text(
                              //         'Or Sign Up with',
                              //         style: TextStyle(
                              //           color: Color(0xff8E8E8E),
                              //         ),
                              //       ),
                              //     ),
                              //     Container(
                              //       width: 90,
                              //       height: 2,
                              //       color: const Color(0xff8E8E8E),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 16,
                              // ),
                              // Center(
                              //   child: Image.asset(AssetsData.googleLogo,
                              //       height: 40, width: 40),
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 160),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Already have an account?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.to(
                                          () => const LoginScreen(),
                                        );
                                      },
                                      child: const Text(
                                        'Log In',
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void showSuccessDialog(BuildContext context, String email) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context, email),
      );
    },
  );
}

Widget contentBox(BuildContext context, String email) {
  return Center(
    child: Stack(
      children: <Widget>[
        Container(
          height: 314,
          width: 343,
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.only(top: 120.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xffFAFAFA).withOpacity(.8),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Positioned(
                left: 20.0,
                right: 20.0,
                child: Image.asset(
                    AssetsData.goConfirmEmail), // Change to your image path
              ),
              const Text(
                'Confirm Your Email Address',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'We sent a confirmation email to ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                email,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
              const Text(
                '. Check your email and click on the confirmation link to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 40,
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Button border radius
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18, // Text size
                      fontWeight: FontWeight.w400, // Text weight
                    ),
                    elevation: 5, // Button elevation
                  ),
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.close, size: 40),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ],
    ),
  );
}
