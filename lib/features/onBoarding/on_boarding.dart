import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/onBoarding/elv_button.dart';
import 'package:custom_craft/features/onBoarding/on_boarding_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class On1 extends StatefulWidget {
  const On1({Key? key}) : super(key: key);

  @override
  State<On1> createState() => _On1State();
}

class _On1State extends State<On1> {
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Stack(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xffFAFAFA).withOpacity(.7),
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.previousPage(
                          duration: const Duration(microseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn);
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: AssetsColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        // page view of images and titles and sub titles
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 48, right: 24, left: 24, bottom: 42),
                          child: Image.asset(
                            OnBoardingModel.onBoardingScreens[index].imgPath,
                            height: 321,
                            width: 327,
                          ),
                        ),
                        // NextPage Button
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const CircleAvatar(
                              backgroundColor: AssetsColors.primaryColor,
                              radius: 25,
                            ),
                            IconButton(
                              onPressed: () {
                                controller.nextPage(
                                    duration:
                                        const Duration(microseconds: 1000),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              },
                              icon: const Icon(
                                Icons.arrow_right_alt_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          OnBoardingModel.onBoardingScreens[index].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ), //title
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                          ),
                          child: Text(
                            OnBoardingModel.onBoardingScreens[index].subTitle,
                            textAlign: TextAlign.center,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff8E8E8E),
                            ),
                          ),
                        ), //sub
                        const SizedBox(
                          height: 32,
                        ),
                        SmoothPageIndicator(
                          controller: controller,
                          count: 3,
                          effect: const ExpandingDotsEffect(
                            activeDotColor: AssetsColors.primaryColor,
                            dotHeight: 4,
                            spacing: 5,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        // sign up and log in buttons
                        const ElavButton(),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
