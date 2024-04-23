import 'package:custom_craft/constans/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../features/Category/category.dart';

class CustomAppBarDesign extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarDesign({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3, color: Colors.white),
        ),
      ),
      child: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: SizedBox(
              height: 39,
              width: 75,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AssetsColors.primaryColor, // Background color
                  // foregroundColor:
                  //     Colors.white, // Text color
                  // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Button border radius
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16, // Text size
                    fontWeight: FontWeight.w400, // Text weight
                  ),
                  elevation: 1, // Button elevation
                ),
                child: const Text('Save'),
              ),
            ),
          ),
        ],
        centerTitle: true,
        toolbarHeight: 90,
        elevation: 0,
        title: const Text(
          'customize',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xffFAFAFA).withOpacity(.6),
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 17, top: 13),
          child: IconButton(
            icon: const Icon(
              Icons.close_rounded,
              color: Color(0xff2E2E2E),
              size: 30,
            ),
            onPressed: () {
              Get.to(() => const CategoryScreen(),
                  transition: Transition.fadeIn);
            },
          ),
        ),
      ),
    );
  }
}
