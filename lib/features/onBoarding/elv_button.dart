import 'package:custom_craft/constans/app_string/app_string.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/features/SignUp/sign_up.dart';
import 'package:custom_craft/features/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ElavButton extends StatelessWidget {
  const ElavButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // SIGNUP BUTTON
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            height: 43,
            width: 135,
            child: ElevatedButton(
              onPressed: () {
                Get.to(
                  () => const SignUpScreen(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Background color
                foregroundColor: AssetsColors.primaryColor, // Text color
                // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12), // Button border radius
                ),
                textStyle: const TextStyle(
                  fontSize: 16, // Text size
                  fontWeight: FontWeight.w400, // Text weight
                ),
                elevation: 1, // Button elevation
              ),
              child: const Text(AssetsStrings.appSignUp),
            ),
          ),
        ),
        const Spacer(),
        // login button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SizedBox(
            height: 43,
            width: 135,
            child: ElevatedButton(
              onPressed: () {
                Get.to(
                  () => const LoginScreen(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AssetsColors.primaryColor, // Background color
                // foregroundColor:
                //     Colors.white, // Text color
                // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12), // Button border radius
                ),
                textStyle: const TextStyle(
                  fontSize: 16, // Text size
                  fontWeight: FontWeight.w400, // Text weight
                ),
                elevation: 5, // Button elevation
              ),
              child: const Text(AssetsStrings.appLogin),
            ),
          ),
        ),
      ],
    );
  }
}
