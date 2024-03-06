import 'package:custom_craft/core/widget/image_background.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGroundImage(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Text('category'),
          )),
    );
  }
}