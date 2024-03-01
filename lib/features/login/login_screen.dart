import 'package:custom_craft/constans/app_string/app_string.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/text_filed_data.dart';
import 'package:custom_craft/features/SignUp/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _rememberMe = false;

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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
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
                                      fontWeight: FontWeight.w400),
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
                                      fontWeight: FontWeight.w500),
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
                                  hintTitle: 'Email',
                                  controller: _emailController,
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
                                hintTitle: 'Password',
                                controller: _passwordController,
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
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Remember me',
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xff8E8E8E)),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      // Handle Forgot Password
                                    },
                                    // Forgot Password
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(color: Colors.red),
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
                                  onPressed: () {},
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
                                  child: const Text(AssetsStrings.appLogin),
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
                                  padding: EdgeInsets.symmetric(horizontal: 5),
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
                                padding:
                                    const EdgeInsets.only(top: 102, bottom: 32),
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
