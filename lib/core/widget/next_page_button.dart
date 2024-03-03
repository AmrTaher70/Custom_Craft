import 'package:custom_craft/constans/colors/colors.dart';
import 'package:flutter/material.dart';

class NextPageButton extends StatelessWidget {
  const NextPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    return Stack(
      alignment: Alignment.center,
      children: [
        const CircleAvatar(
          backgroundColor: AssetsColors.primaryColor,
          radius: 25,
        ),
        IconButton(
          onPressed: () {
            controller.nextPage(
                duration: const Duration(microseconds: 1000),
                curve: Curves.fastLinearToSlowEaseIn);
          },
          icon: const Icon(
            Icons.arrow_right_alt_outlined,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
