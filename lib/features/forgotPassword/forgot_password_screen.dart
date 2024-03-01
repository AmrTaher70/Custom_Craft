import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/text_filed_data.dart';
import 'package:custom_craft/features/forgotPassword/verify_email_screen.dart';
import 'package:custom_craft/features/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _forgetEmailController = TextEditingController();

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
                        () => const LoginScreen(),
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
                    'Forgot Password',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
                        hintTitle: 'Email',
                        controller: _forgetEmailController,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.email_outlined),
                        ) // Adding email icon
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
                          () => const VerifyEmailScreen(),
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
                      child: const Text('Send'),
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
