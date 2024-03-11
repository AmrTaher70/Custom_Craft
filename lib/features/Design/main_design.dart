import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/widget/custom_app_bar_for_design.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:flutter/material.dart';

class MainDesign extends StatefulWidget {
  const MainDesign({Key? key}) : super(key: key);

  @override
  State<MainDesign> createState() => _MainDesignState();
}

class _MainDesignState extends State<MainDesign> {
  final PageController _pageController = PageController(viewportFraction: 0.2);

  int _currentPageIndex = 0;

  List<String> images = [
    AssetsData.hoodie,
    AssetsData.hoodieBack,
    // Add more image paths as needed
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_handlePageChange);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlePageChange() {
    setState(() {
      _currentPageIndex = _pageController.page!.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;

    return BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBarDesign(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                images[_currentPageIndex],
                height: 343,
                width: 407,
              ),
              SizedBox(
                height: 120,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    double scaleFactor = index == _currentPageIndex ? 1.0 : 0.8;
                    return Transform.scale(
                      scale: scaleFactor,
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              Container(
                height: 96,
                width: width,
                decoration: BoxDecoration(
                    color: const Color(0xffFAFAFA).withOpacity(.6),
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

  // Column(
  //   crossAxisAlignment: CrossAxisAlignment.stretch,
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: [
  //     Expanded(
  //       child: PageView.builder(
  //         physics: const NeverScrollableScrollPhysics(),
  //         controller: _pageController,
  //         onPageChanged: (int index) {
  //           setState(() {
  //             _currentPageIndex = index;
  //           });
  //         },
  //         itemCount: images.length,
  //         itemBuilder: (context, index) {
  //           return Padding(
  //             padding: const EdgeInsets.only(
  //               top: 20,
  //             ),
  //             child: Image.asset(
  //               images[index],
  //               height: 343,
  //               width: 407,
  //               fit: BoxFit.fitHeight,
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //     Center(
  //       child: SizedBox(
  //         height: 80,
  //         child: ListView.builder(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: images.length - 1,
  //           itemBuilder: (context, index) {
  //             return Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //               child: GestureDetector(
  //                 onTap: () {
  //                   _pageController?.animateToPage(
  //                     index + 1,
  //                     duration: const Duration(milliseconds: 500),
  //                     curve: Curves.ease,
  //                   );
  //                 },
  //                 child: Image.network(
  //                   images[index + 1],
  //                   height: 80,
  //                   width: 80,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ),
  //   ],
  // ),

  // Column(
  //   crossAxisAlignment: CrossAxisAlignment.center,
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: [
  //     Center(
  //       child: Expanded(
  //         child: PageView.builder(
  //           controller: itemController,
  //           itemCount: 2,
  //           itemBuilder: (context, index) {
  //             return Column(
  //               children: [
  //                 // page view of images and titles and sub titles

  //                 Image.asset(
  //                   ItemModel.mainDesign[index].imgPath,
  //                   height: 100,
  //                   width: 100,
  //                 ),
  //               ],
  //             );
  //           },

  //         ),
  //       ),
  //     ),
  //   ],
  // ),

