import 'package:custom_craft/core/utils/assets.dart';

import 'package:custom_craft/core/widget/sliding_text.dart';
import 'package:custom_craft/features/onBoarding/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  //handle the time
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  @override
  void initState() {
    super.initState();
    initAnimation();
    navigateToOn();
  }

  void initAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 15), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
  }

  void navigateToOn() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => const On1(),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 250));
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsData.logo,
              height: 107,
              width: 128,
            ),
            const SizedBox(
              height: 8,
            ),
            SlidingText(
              slidingAnimation: slidingAnimation,
            ),
          ],
        ),
      ),
    );
  }
}
