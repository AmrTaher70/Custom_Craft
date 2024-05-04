import 'package:custom_craft/core/utils/models/add_photos_model.dart';
import 'package:custom_craft/core/utils/models/ai_image.dart';
import 'package:custom_craft/core/utils/models/color_item_model.dart';
import 'package:custom_craft/core/utils/models/saved_photo_model.dart';
import 'package:custom_craft/core/utils/models/text_model.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/Design/AddIcons/add_icons.dart';
import 'package:custom_craft/features/Design/Shapes/add_shape.dart';
import 'package:custom_craft/features/home/home_screen.dart';
import 'package:custom_craft/features/splash/splash/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TextModel()),
          ChangeNotifierProvider(create: (context) => ColorItemModel()),
          ChangeNotifierProvider(create: (context) => PhotoProvider()),
          ChangeNotifierProvider(create: (context) => AiPhotoProvider()),
          ChangeNotifierProvider(create: (context) => ShapeProvider()),
          ChangeNotifierProvider(create: (context) => IconProvider()),
          ChangeNotifierProvider(create: (context) => SavedImageModel()),
        ],
        child: const MyApp(),
      ),
    ),
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
            child: HomeScreen(),
          ),
        ],
      ),
    );
  }
}
