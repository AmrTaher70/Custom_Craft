import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/Category/category.dart';
import 'package:custom_craft/features/Profile/profile.dart';
import 'package:custom_craft/features/home/home_screen.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _screens[_selectedIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            height: 95,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border(
                top: BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
                right: BorderSide(
                  color: Colors.white,
                  width: 4,
                ),
                left: BorderSide(
                  color: Colors.white,
                  width: 4,
                ),
                bottom: BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
              ),
            ),
            child: BottomNavigationBar(
              backgroundColor: const Color(0xffFCFCFC).withOpacity(.6),
              elevation: 0,
              selectedItemColor: AssetsColors.primaryColor,
              unselectedItemColor: Colors.grey,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_rounded),
                  label: 'Custom',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
