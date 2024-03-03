import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/onBoarding/on_boarding.dart';
import 'package:custom_craft/features/splash/splash/splash_screen.dart';

import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kOnScreen = '/On1';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const BackGroundImage(
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        path: kOnScreen,
        builder: (context, state) => const BackGroundImage(
          child: OnBoardingScreens(),
        ),
      ),
    ],
  );
}
