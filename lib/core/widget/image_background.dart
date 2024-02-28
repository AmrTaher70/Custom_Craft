import 'package:custom_craft/core/utils/assets.dart';
import 'package:flutter/material.dart';

class BackGroundImage extends StatefulWidget {
  const BackGroundImage({super.key, required this.child});
  final Widget child;

  @override
  State<BackGroundImage> createState() => _BackGroundImageState();
}

class _BackGroundImageState extends State<BackGroundImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsData.backGround),
              fit: BoxFit.cover,
            ),
          ),
        ), // Or another preferred fit

        widget.child,
      ],
    );
  }
}
