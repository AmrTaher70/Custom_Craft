import 'package:custom_craft/constans/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBarForSimilarity extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarForSimilarity({
    super.key,
    this.text,
    required this.onPressed,
  });
  @override
  Size get preferredSize => const Size.fromHeight(70);
  final Text? text;
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
                  backgroundColor: Colors.white, // Background color
                  // foregroundColor:
                  //     Colors.white, // Text color
                  // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: AssetsColors.primaryColor),
                  ),

                  textStyle: const TextStyle(
                    fontSize: 16, // Text size
                    fontWeight: FontWeight.w400, // Text weight
                  ),
                  elevation: 1, // Button elevation
                ),
                child: const Text(
                  'Edit',
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
              Navigator.pop(
                  context); // Navigate back when close button is pressed
            },
          ),
        ),
      ),
    );
  }
}
