import 'package:custom_craft/core/widget/custom_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:custom_craft/core/widget/custom_app_bar.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/home/home_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  // List of items with their front and back image paths and names
  final List<Map<String, String>> items = const [
    {
      'name': 'Hoodie',
      'front': 'assets/images/hodi.png',
      'back': 'assets/images/hoodieBack.png'
    },
    {
      'name': 'T-Shirt',
      'front': 'assets/images/tshirt_front.png',
      'back': 'assets/images/tshirt_back.png'
    },
    {
      'name': 'Long Sleeve',
      'front': 'assets/images/long_sleeve_woman_front.png',
      'back': 'assets/images/long_sleeve_woman_back.png'
    },
    {
      'name': 'Women T-Shirt',
      'front': 'assets/images/front_tshirt_woman.png',
      'back': 'assets/images/tshirt_woman_back.png'
    },
    {
      'name': 'Baby Shirt',
      'front': 'assets/images/baby_shirt_front.png',
      'back': 'assets/images/baby_shirt_back.png'
    },
    {
      'name': 'Baby',
      'front': 'assets/images/baby_front.png',
      'back': 'assets/images/baby_back.png'
    },
    {
      'name': 'Bag',
      'front': 'assets/images/bag.png',
      'back': 'assets/images/bag.png'
    },
    {
      'name': 'Cover',
      'front': 'assets/images/phone.png',
      'back': 'assets/images/phone.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
      child: Scaffold(
        appBar: CustomAppBar(
          text: const Text(
            'Choose a Blank',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff2E2E2E),
              size: 24,
            ),
            onPressed: () {
              Get.to(() => const HomeScreen(), transition: Transition.fadeIn);
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          child: GridView.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return CustomCard(
                frontImage: item['front']!,
                backImage: item['back']!,
                itemName: item['name']!,
              );
            },
          ),
        ),
      ),
    );
  }
}
