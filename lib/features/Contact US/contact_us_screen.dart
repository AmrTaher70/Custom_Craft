import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
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
            const Center(
              child: Stack(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
