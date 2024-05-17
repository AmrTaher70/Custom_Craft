import 'package:custom_craft/api/login_model.dart';
import 'package:custom_craft/constans/app_string/app_string.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/text_filed_data.dart';
import 'package:custom_craft/features/CreateNewPassword/create_new_passwort_screen.dart';
import 'package:custom_craft/features/SignUp/sign_up.dart';
import 'package:custom_craft/features/forgotPassword/forgot_password_screen.dart';
import 'package:custom_craft/features/home/home_screen.dart';
import 'package:custom_craft/helper/api.helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _showPassword = false;
  bool rememberMe = false;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Api api = Api();

  Future logIn() async {
    try {
      // Validate the form
      if (!formKey.currentState!.validate()) {
        return;
      }

      // Show loading indicator
      setState(() {
        isLoading = true;
      });

      // Create an instance of LoginModel using user input
      LoginModel loginData = LoginModel(
        email: emailController.text,
        password: passwordController.text,
        rememberMe: rememberMe,
      );

      // Convert LoginModel to JSON
      Map<String, dynamic> loginJson = loginData.toJson();

      // Make API call to login
      dynamic response = await api.post(
        url: 'http://customcrafttt.somee.com/api/Account/login',
        body: loginJson,
      );
      // Handle response
      print('LogIn successful: $response');

      // Retrieve token from the response
      String? token = response['token'];

      // Save token
      api.saveToken(token!);

      // Show snackbar with success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('LogIn successful'),
        ),
      );

      // Navigate to home screen
      Get.to(() => const HomeScreen(), transition: Transition.fadeIn);
    } catch (e) {
      // Handle any exceptions
      print('Error during logIn: $e');

      // Show snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
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

        return BackGroundImage(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 131, bottom: 60),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            height: 550,
                            width: width < 600
                                ? screenSize.width * 0.9
                                : 327, // Adjust width based on screen size
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
                                    'Welcome Back!',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width < 600
                                        ? 40
                                        : width -
                                            80), // Adjust padding based on screen size
                                child: const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Log In',
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
                                    labelText: 'Email',
                                    controller: emailController,
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
                                    ) // Adding email icon
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
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                    icon: _showPassword
                                        ? const Icon(Icons.visibility_outlined)
                                        : const Icon(
                                            Icons.visibility_off_outlined),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width < 600 ? 40 : width - 80),
                                child:
                                    // Remember me box
                                    Row(
                                  children: [
                                    Checkbox(
                                      value: rememberMe,
                                      onChanged: (value) {
                                        setState(() {
                                          rememberMe = value ?? false;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Remember me',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff8E8E8E)),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        Get.to(
                                          () => const ForgotPasswordScreen(),
                                        );
                                      },
                                      // Forgot Password
                                      child: const Text(
                                        'Forgot Password?',
                                        style:
                                            TextStyle(color: Color(0xffD33535)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              // Login Button
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
                                          await logIn();
                                          // Your login logic here
                                        } catch (e) {
                                          // Hide loading indicator
                                          setState(() {
                                            isLoading = false;
                                          });

                                          // Display debug message with error
                                          debugPrint('Error during logIn: $e');

                                          // Show snackbar with error message
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text('An error occurred: $e'),
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
                                      backgroundColor: AssetsColors
                                          .primaryColor, // Background color
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
                                        : const Text(AssetsStrings.appLogin),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 28,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 2,
                                    color: const Color(0xff8E8E8E),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      'Or Log in with',
                                      style: TextStyle(
                                        color: Color(0xff8E8E8E),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 90,
                                    height: 2,
                                    color: const Color(0xff8E8E8E),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Center(
                                child: Image.asset(AssetsData.googleLogo,
                                    height: 40, width: 40),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 102, bottom: 32),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Don’t have an account?',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.to(
                                            () => const SignUpScreen(),
                                          );
                                        },
                                        child: const Text(
                                          'Sign up',
                                          style: TextStyle(
                                              color: AssetsColors.primaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
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
