import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/widget/custom_app_bar.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/CreateNewPassword/create_new_passwort_screen.dart';
import 'package:custom_craft/features/forgotPassword/new_password_screen.dart';
import 'package:custom_craft/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Category/category.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _onItemTapped(int index) {
    setState(() {});
    if (index == 0) {
      Get.to(() => const HomeScreen(), transition: Transition.fadeIn);
    } else if (index == 1) {
      Get.to(() => const Profile(), transition: Transition.fadeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
      child: Scaffold(
        appBar: CustomAppBar(
          text: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff2E2E2E),
              size: 24,
            ),
            onPressed: () {
              Get.to(() => const HomeScreen(), transition: Transition.fadeIn);
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset(
                        AssetsData.navBarBackGround,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                            top: 18,
                            bottom: 14,
                          ),
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _onItemTapped(0);
                                },
                                icon: const Icon(Icons.home_outlined,
                                    color: Color(0xff8E8E8E)),
                                iconSize: 32,
                              ),
                              const Text(
                                'Home',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff8E8E8E),
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(top: 70, bottom: 16),
                          child: Center(
                              child: Text(
                            'Customize',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff8E8E8E),
                                fontWeight: FontWeight.w400),
                          )),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 24,
                            top: 18,
                            bottom: 14,
                          ),
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _onItemTapped(1);
                                },
                                icon: const Icon(Icons.person_2_outlined,
                                    color: AssetsColors.primaryColor),
                                iconSize: 32,
                              ),
                              const Text(
                                'Profile',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AssetsColors.primaryColor,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(AssetsData.imageProfile),
                        minRadius: 32,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Amr Taher',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const HomeScreen(),
                          transition: Transition.fadeIn);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.brush_outlined),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'My Designs',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right_outlined),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: 343,
                  color: const Color(0xffD8D8D8),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const CreateNewPasswordScreen(),
                          transition: Transition.fadeIn);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.key),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Change Password',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right_outlined),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: 343,
                  color: const Color(0xffD8D8D8),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const HomeScreen(),
                          transition: Transition.fadeIn);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.help_outline),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Help & Support',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right_outlined),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: 343,
                  color: const Color(0xffD8D8D8),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const HomeScreen(),
                          transition: Transition.fadeIn);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.logout_outlined),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Sign out',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        // Spacer(),
                        // Icon(Icons.keyboard_arrow_right_outlined),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: 343,
                  color: const Color(0xffD8D8D8),
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => const CategoryScreen(),
                  transition: Transition.fadeIn);
            },
            backgroundColor: AssetsColors.primaryColor,
            elevation: 5,
            child: const Icon(Icons.add),
            // shape: BeveledRectangleBorder(),
          ),
        ),
      ),
    );
  }
}
