import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/text_filed_data.dart';
import 'package:custom_craft/features/Profile/profile.dart';
import 'package:custom_craft/features/forgotPassword/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../login/login_screen.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

final TextEditingController _newPasswordController = TextEditingController();
final TextEditingController _previousPasswordController =
    TextEditingController();
final TextEditingController _confirmNewPasswordController =
    TextEditingController();
bool _showPassword = false;

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFiledData(
                      labelText: 'Previous Password',
                      controller: _previousPasswordController,
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
                      controller: _newPasswordController,
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
                      controller: _confirmNewPasswordController,
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
                      onPressed: () {
                        Get.to(
                          () => const LoginScreen(),
                        );
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
                      child: const Text('Save'),
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
            )
          ],
        ),
      ),
    );
  }
}
