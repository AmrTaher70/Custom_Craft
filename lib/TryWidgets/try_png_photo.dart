import 'package:custom_craft/core/widget/image_background.dart';
import 'package:flutter/material.dart';

class PngImage extends StatefulWidget {
  const PngImage({super.key});

  @override
  State<PngImage> createState() => _PngImageState();
}

class _PngImageState extends State<PngImage> {
  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 2.7 / 4,
              child: Image.network(
                'http://customcraftt.somee.com/images/items/cover.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
