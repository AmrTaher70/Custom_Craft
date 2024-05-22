import 'package:custom_craft/core/utils/models/selected_item.dart';
import 'package:custom_craft/core/widget/custom_cart.dart';
import 'package:custom_craft/features/Design/MainDesign/main_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:custom_craft/core/widget/custom_app_bar.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/home/home_screen.dart';
import 'package:provider/provider.dart';

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
      'name': 'Long Sleeve Woman',
      'front': 'assets/images/long_sleeve_woman_front.png',
      'back': 'assets/images/long_sleeve_woman_back.png'
    },
    {
      'name': 'T-Shirt Women',
      'front': 'assets/images/front_tshirt_woman.png',
      'back': 'assets/images/tshirt_woman_back.png'
    },
    {
      'name': 'Baby Bodysuit',
      'front': 'assets/images/baby_shirt_front.png',
      'back': 'assets/images/baby_shirt_back.png'
    },
    {
      'name': 'Baby T-shirt',
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
            clipBehavior: Clip.none,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Access the provider
                  var selectedPhotosProvider =
                      Provider.of<ItemPhotosProvider>(context, listen: false);

                  // Set selected photos in the provider
                  selectedPhotosProvider.setSelectedPhotos(
                      items[index]['front']!, items[index]['back']!);

                  // Navigate to MainDesign screen
                  Get.to(() => const MainDesign());
                },
                child: CustomCard(
                  frontImage: items[index]['front']!,
                  backImage: items[index]['back']!,
                  itemName: items[index]['name']!,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
