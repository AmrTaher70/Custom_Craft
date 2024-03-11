import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/widget/custo_nav_bar.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/nav_bar.dart';
import 'package:custom_craft/features/Category/category.dart';
import 'package:custom_craft/features/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _selectedIndex = 0;

final List<Widget> _screens = [
  const HomeScreen(),
  const Profile(),
];

class _HomeScreenState extends State<HomeScreen> {
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
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      AssetsData.navBarBackGround,
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
                                icon: Icon(Icons.home_outlined,
                                    color: _selectedIndex == 0
                                        ? AssetsColors.primaryColor
                                        : const Color(0xff8E8E8E)),
                                iconSize: 24,
                              ),
                              const Text(
                                'Home',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AssetsColors.primaryColor,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(top: 58, bottom: 16),
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
                                icon: Icon(Icons.person_2_outlined,
                                    color: _selectedIndex == 1
                                        ? AssetsColors.primaryColor
                                        : const Color(0xff8E8E8E)),
                                iconSize: 24,
                              ),
                              Text(
                                'Profile',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: _selectedIndex == 1
                                        ? AssetsColors.primaryColor
                                        : const Color(0xff8E8E8E),
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
            const Center(
              child: Text(
                'Page 1',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 25),
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
