import 'package:custom_craft/api/forgot_password_model.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/text_filed_data.dart';
import 'package:custom_craft/features/forgotPassword/new_password_screen.dart';
import 'package:custom_craft/features/forgotPassword/verify_email_screen.dart';
import 'package:custom_craft/features/login/login_screen.dart';
import 'package:custom_craft/helper/api.helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgetEmailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Api api = Api();
  Future forgotPass() async {
    try {
      // Validate the form
      if (!formKey.currentState!.validate()) {
        return;
      }

      // Show loading indicator
      setState(() {
        isLoading = true;
      });

      // Create an instance of SignUpModel using user input
      ForgotPasswordModel forgotPasswordData = ForgotPasswordModel(
        email: forgetEmailController.text,
      );

      // Convert SignUpModel to JSON
      Map<String, dynamic> forgotPasswordJson = forgotPasswordData.toJson();

      // Make API call to sign up
      dynamic response = await api.post(
        url: 'http://customcraftt.somee.com/api/Account/forgetPassword',
        body: forgotPasswordJson,
      );

      // Handle response (e.g., show success message)
      print('successful: $response');

      // Navigate to sign-in screen
      Get.to(() => const NewPasswordScreen(), transition: Transition.fadeIn);
    } catch (e) {
      // Handle any exceptions
      print('Error Login up: $e');

      // Hide loading indicator
      setState(() {
        isLoading = false;
      });

      // Check for specific error messages and provide feedback to the user
      String errorMessage = 'An error occurred. Please try again later.';
      if (e is Exception) {
        // Extract the error message from the exception
        errorMessage = e.toString();
        if (errorMessage.toLowerCase().contains("unauthorized")) {
          errorMessage = 'Wrong email or password.';
        }
      }
      errorMessage = e.toString();
      if (errorMessage.endsWith('BadRequest}')) {
        errorMessage = "'User not Found, Couldn't sent please try again!'";
      }

      // Show snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    } finally {
      // Hide loading indicator after login attempt is completed
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
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
                      Get.to(() => const LoginScreen(),
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
                      'Forgot Password',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    Image.asset(
                      AssetsData.forgetPassword,
                      height: 187,
                      width: 187,
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34),
                      child: Text(
                        'Please enter your email address to \n       receive a verification card ',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textWidthBasis: TextWidthBasis.longestLine,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff8E8E8E),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFiledData(
                        labelText: 'Email',
                        controller: forgetEmailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          } else if (!value.contains('@') ||
                              !value.contains('.')) {
                            return 'Invalid email format';
                          }
                          return null; // Return null if validation succeeds
                        },
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.email_outlined),
                        ),
                        // Adding email icon
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

                              await forgotPass();
                            } catch (e) {
                              // Hide loading indicator
                              setState(() {
                                isLoading = false;
                              });

                              // Display debug message with error
                              debugPrint('Error during logIn: $e');

                              // Show snackbar with error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('An error occurred: $e'),
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
                            : const Text('Send'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
