import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/SignUp/sign_up.dart';
import 'package:custom_craft/features/login/login_screen.dart';
import 'package:custom_craft/features/onBoarding/on_boarding.dart';
import 'package:custom_craft/features/splash/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
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
            child: SignUpScreen(),
          )
        ],
      ),
    );
  }
}
