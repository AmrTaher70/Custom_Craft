import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/Profile/profile.dart';
import 'package:custom_craft/features/home/home_screen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  // final List<Widget> _screens = [
  //   const HomeScreen(),
  //   const Profile(),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Profile()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: AssetsColors.primaryColor,
            elevation: 5,
            child: const Icon(Icons.add),
            // shape: BeveledRectangleBorder(),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Column(
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
                          Text(
                            'Home',
                            style: TextStyle(
                                fontSize: 16,
                                color: _selectedIndex == 0
                                    ? AssetsColors.primaryColor
                                    : const Color(0xff8E8E8E),
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
      ),
    );
  }
}
