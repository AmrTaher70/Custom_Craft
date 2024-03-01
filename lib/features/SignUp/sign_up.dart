import 'package:custom_craft/constans/app_string/app_string.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/text_filed_data.dart';
import 'package:custom_craft/features/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _showPassword = false;

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
                                  'Sign Up',
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
                                hintTitle: 'User Name',
                                controller: _userNameController,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.person_2_outlined),
                                ), // Adding email icon
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: TextFiledData(
                                hintTitle: 'Email',
                                controller: _emailController,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.email_outlined),
                                ), // Adding email icon
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
                              child: TextFiledData(
                                hintTitle: 'Confirm Password',
                                controller: _confirmPasswordController,
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
                              height: 24,
                            ),
                            // Sign Up Button
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 45,
                                width: 305,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AssetsColors.primaryColor,
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
                                  child: const Text(AssetsStrings.appSignUp),
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
                                    'Or Sign Up with',
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
                              height: 16,
                            ),
                            Center(
                              child: Image.asset(AssetsData.googleLogo,
                                  height: 40, width: 40),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 84, bottom: 40),
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
