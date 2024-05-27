import 'package:custom_craft/api/forgot_password_model/forgot_password_model.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/text_filed_data.dart';
import 'package:custom_craft/features/forgotPassword/new_password_screen.dart';
import 'package:custom_craft/features/login/login_screen.dart';
import 'package:custom_craft/helper/api.helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  @override
  void initState() {
    super.initState();
    // Load saved email if available
    _loadEmail();
  }

  // Function to load saved email
  _loadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('forget_email');
    if (savedEmail != null) {
      setState(() {
        forgetEmailController.text = savedEmail;
      });
    }
  }

  Future _saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('forget_email', email);
  }

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
      await _saveEmail(forgetEmailController.text);

      // Create an instance of SignUpModel using user input
      ForgotPasswordModel forgotPasswordData = ForgotPasswordModel(
        email: forgetEmailController.text,
      );

      // Convert SignUpModel to JSON
      Map<String, dynamic> forgotPasswordJson = forgotPasswordData.toJson();

      // Make API call to sign up
      dynamic response = await api.post(
        url: 'http://customcrafttt.somee.com/api/Account/forgetPassword',
        body: forgotPasswordJson,
      );

      // Handle response (e.g., show success message)
      print('successful: $response');
      String? token = response['token'];

      // Save token
      await api.saveToken(token!);

      // Navigate to sign-in screen
      // Get.to(
      //     () => NewPasswordScreen(
      //           forgotemail: forgetEmailController.text,
      //         ),
      //     transition: Transition.fadeIn);
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
                              showSuccessDialog(
                                  context, forgetEmailController.text);
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
        // BackdropFilter to blur the background
        Container(
          height: 320,
          width: 343,
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.only(top: 120.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xffFAFAFA).withOpacity(.8),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.white, width: 3)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Positioned(
                  left: 20.0,
                  right: 20.0,
                  child: Image.asset(
                      AssetsData.goConfirmEmail) // Change to your image path
                  ),
              const Text(
                'Confirm Your Email Address',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8.0),
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
              const SizedBox(height: 10.0),
              SizedBox(
                height: 40,
                width: 140,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const NewPasswordScreen(),
                        transition: Transition.fadeIn);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AssetsColors.primaryColor, // Background color
                    // foregroundColor:
                    //     Colors.white, // Text color
                    // Button padding
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
                  child: const Text(
                    'Reset Password',
                    textAlign: TextAlign.center,
                  ),
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
