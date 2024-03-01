import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/SignUp/sign_up.dart';
import 'package:custom_craft/features/forgotPassword/forgot_password_screen.dart';
import 'package:custom_craft/features/forgotPassword/verify_email_screen.dart';
import 'package:custom_craft/features/login/login_screen.dart';
import 'package:custom_craft/features/splash/splash/splash_screen.dart';
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
            child: VerifyEmailScreen(),
          )
        ],
      ),
    );
  }
}
