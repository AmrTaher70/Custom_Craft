import 'package:custom_craft/constans/app_string/app_string.dart';
import 'package:custom_craft/core/utils/assets/assets.dart';

class OnBoardingModel {
  final String imgPath;
  final String title;
  final String subTitle;
  OnBoardingModel(
      {required this.imgPath, required this.title, required this.subTitle});
  static List<OnBoardingModel> onBoardingScreens = [
    OnBoardingModel(
        imgPath: AssetsData.onBoarding1,
        title: AssetsStrings.appTitleOn1,
        subTitle: AssetsStrings.appSubOn1),
    OnBoardingModel(
        imgPath: AssetsData.onBoarding2,
        title: AssetsStrings.appTitleOn2,
        subTitle: AssetsStrings.appSubOn2),
    OnBoardingModel(
        imgPath: AssetsData.onBoarding3,
        title: AssetsStrings.appTitleOn3,
        subTitle: AssetsStrings.appSubOn3)
  ];
}
