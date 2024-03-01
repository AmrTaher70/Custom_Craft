import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/pin_entry.dart';
import 'package:custom_craft/features/forgotPassword/forgot_password_screen.dart';
import 'package:custom_craft/features/forgotPassword/new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
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
                      Get.to(
                        () => const ForgotPasswordScreen(),
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
                    'Verify Your Email',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Image.asset(
                    AssetsData.verify,
                    height: 187,
                    width: 187,
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 34),
                    child: Text(
                      'Please enter your 4 digit code that \n       sent to your email address ',
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
                    height: 24,
                  ),
                  const PinEntry(), // Pin entry
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: 359,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                          () => const NewPasswordScreen(),
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
                      child: const Text('Verify'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 160, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Didn’t receive a code?',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Resend',
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
