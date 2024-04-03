import 'package:custom_craft/constans/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBarForAddPhoto extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarForAddPhoto({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  @override
  Size get preferredSize => const Size.fromHeight(70);

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
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Background color
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
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500), // Change text color as needed
      ),
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(bottom: 17, top: 13),
        child: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.black, // Change icon color as needed
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(
                context); // Navigate back when close button is pressed
          },
        ),
      ),
    );
  }
}
