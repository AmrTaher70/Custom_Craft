import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/widget/custo_nav_bar.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/Ctegory/category.dart';
import 'package:custom_craft/features/Profile/profile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // bottomNavigationBar: CustomNavBar(),
        body: Center(
          child: Text('HomeScreen'),
        ),
      ),

      //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: () {},
      //     backgroundColor: AssetsColors.primaryColor,
      //     elevation: 5,
      //     child: const Icon(Icons.add),
      //     // shape: BeveledRectangleBorder(),
      //   ),
      //   bottomNavigationBar: Container(
      //     decoration:
      //         BoxDecoration(border: Border.all(color: Colors.white, width: 3)),
      //     child: BottomAppBar(
      //       notchMargin: 15.0,
      //       surfaceTintColor: Colors.red,
      //       shape: const CircularNotchedRectangle(),
      //       height: 62,
      //       color: const Color(0xffFAFAFA).withOpacity(.7),
      //       child: Row(
      //         mainAxisSize: MainAxisSize.max,
      //         children: [
      //           const Padding(
      //             padding: EdgeInsets.only(left: 36, top: 18),
      //             child: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 Icon(
      //                   Icons.home_outlined,
      //                   color: Colors.grey,
      //                   size: 24,
      //                 ),
      //                 Text(
      //                   'Home',
      //                   style: TextStyle(fontSize: 16, color: Colors.grey),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           const Spacer(),
      //           Padding(
      //             padding: const EdgeInsets.only(right: 36, top: 18),
      //             child: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 IconButton(
      //                   onPressed: () {},
      //                   icon: const Icon(
      //                     Icons.person_2_outlined,
      //                     color: Colors.grey,
      //                     size: 20,
      //                   ),
      //                 ),
      //                 const Text(
      //                   'Profile',
      //                   style: TextStyle(fontSize: 16, color: Colors.grey),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // )
    );
  }
}
