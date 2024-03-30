import 'package:custom_craft/core/widget/custom_app_bar.dart';
import 'package:custom_craft/core/widget/custom_cart.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
      child: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          child: GridView.builder(
            itemCount: 8,
            clipBehavior: Clip.none,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              return const CustomCard();
            },
          ),
        ),
      ),
    );
  }
}
