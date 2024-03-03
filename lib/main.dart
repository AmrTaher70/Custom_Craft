import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/line_of_onboarding.dart';
import 'package:custom_craft/features/onBoarding/on_boarding.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(
    DevicePreview(enabled: true, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          BackGroundImage(
            child: LineOfOnBoarding(),
          )
        ],
      ),
    );
  }
}
