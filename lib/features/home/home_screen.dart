import 'dart:typed_data';

import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/utils/models/saved_photo_model.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/Category/category.dart';
import 'package:custom_craft/features/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

import '../Design/main_design.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _selectedIndex = 0;

// final List<Widget> _screens = [
//   const HomeScreen(),
//   const Profile(),
// ];

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
    Uint8List? savedPhoto = Provider.of<SavedImageModel>(context).savedImage;

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
            Center(
              child: savedPhoto != null
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: GridView.builder(
                        itemCount: 1,
                        clipBehavior: Clip.none,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 0,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 153,
                            width: 164,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.grey.withOpacity(.1),
                                  spreadRadius: 20,
                                  offset: const Offset(10, 10),
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainDesign()),
                                  );
                                },
                                child: Card(
                                  color:
                                      const Color(0xffADADAD).withOpacity(.1),
                                  elevation: 0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Image.memory(
                                          savedPhoto,
                                          height: 118,
                                          width: 98,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AssetsData.homePage),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'No Designs Yet',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 23),
                          child: Text(
                            'Click the button below to add your personal touch and customize your piece with your own taste',
                            maxLines: 4,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xff8E8E8E),
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoryScreen()),
              );
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
