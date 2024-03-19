import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/features/Design/main_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class CustomAppBarForTools extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarForTools({super.key, required this.text});
  @override
  Size get preferredSize => const Size.fromHeight(70);
  final Text text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SizedBox(
            height: 39,
            width: 75,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Background color
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
              child: const Text(
                'Done',
                style: TextStyle(color: AssetsColors.primaryColor),
              ),
            ),
          ),
        ),
      ],
      centerTitle: true,
      toolbarHeight: 90,
      elevation: 0,
      title: text,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 17, top: 13),
        child: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Color(0xff2E2E2E),
            size: 30,
          ),
          onPressed: () {
            Get.to(() => const MainDesign(), transition: Transition.upToDown);
          },
        ),
      ),
    );
  }
}
