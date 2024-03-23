import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/widget/custom_app_bar_for_design.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/Design/AddText/add_text_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/utils/models/text_model.dart';

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
    final textModel = Provider.of<TextModel>(context);
    final text = textModel.text;
    final color = textModel.color;
    final align = textModel.align;
    final font = textModel.font;

    return BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBarDesign(),
        body: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(AssetsData.BackGroundOfItem),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            images[_currentPageIndex],
                            height: 407,
                            width: 343,
                            fit: BoxFit.fitHeight,
                          ),
                          Positioned(
                            height: 350,
                            left: 100,
                            right: 100,
                            child: Center(
                              child: Consumer<TextModel>(
                                builder: (context, textModel, child) {
                                  return Text(
                                    textModel.text.isEmpty
                                        ? 'Default text'
                                        : textModel.text,
                                    style: GoogleFonts.getFont(
                                      textModel.font,
                                      fontSize: 24.0,
                                      color: textModel.color,
                                    ),
                                    textAlign: textModel.align,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 120,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _pageController,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            double scaleFactor =
                                index == _currentPageIndex ? 1.0 : 0.7;
                            return Transform.scale(
                              scale: scaleFactor,
                              child: Image.asset(
                                images[index],
                                fit: BoxFit.contain,
                                //   color: AssetsColors.primaryColor,
                                // colorBlendMode: BlendMode.modulate,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Container(
                        height: 96,
                        width: width - 5,
                        decoration: BoxDecoration(
                          color: const Color(0xffFAFAFA).withOpacity(.6),
                          border: const Border(
                            top: BorderSide(width: 3, color: Colors.white),
                            right: BorderSide(width: 3, color: Colors.white),
                            left: BorderSide(width: 3, color: Colors.white),
                            bottom: BorderSide(width: 1, color: Colors.white),
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 56,
                                width: 56,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.circular(12)),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.accessibility_rounded),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 56,
                                width: 56,
                                decoration: BoxDecoration(
                                    color:
                                        const Color(0xffD9D9D9).withOpacity(.5),
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Consumer<TextModel>(
                                      builder: (context, textModel, child) {
                                        return Text(
                                          textModel.text.isEmpty
                                              ? 'Text'
                                              : textModel.text,
                                          style: GoogleFonts.getFont(
                                            textModel.font,
                                            fontSize: textModel.text.isEmpty
                                                ? 16.0
                                                : 16.0,
                                            color: textModel.text.isEmpty
                                                ? const Color(0xff8E8E8E)
                                                : textModel.color,
                                          ),
                                          textAlign: textModel.align,
                                        );
                                      },
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 91,
                        width: width - 5,
                        decoration: BoxDecoration(
                          color: const Color(0xffFAFAFA).withOpacity(.6),
                          border: const Border(
                            top: BorderSide(width: 1, color: Colors.white),
                            right: BorderSide(width: 3, color: Colors.white),
                            left: BorderSide(width: 3, color: Colors.white),
                            bottom: BorderSide(width: 3, color: Colors.white),
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(45),
                            bottomRight: Radius.circular(45),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Ai Generator
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.auto_fix_high_outlined,
                                    ),
                                    iconSize: 28,
                                  ),
                                  const Text(
                                    'Ai',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                            // Text
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      final height =
                                          MediaQuery.of(context).size.height;
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: height *
                                                0.75, // This makes the bottom sheet take up 3/4 of the screen height
                                            child: const AddText(),
                                          );
                                        },
                                        isScrollControlled: true,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.text_fields_outlined,
                                    ),
                                    iconSize: 28,
                                  ),
                                  const Text(
                                    'Text',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                            // Color
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.color_lens_outlined,
                                    ),
                                    iconSize: 28,
                                  ),
                                  const Text(
                                    'Color',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                            // Shapes
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.circle_outlined,
                                    ),
                                    iconSize: 28,
                                  ),
                                  const Text(
                                    'Shapes',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                            // Photos
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.photo_outlined,
                                    ),
                                    iconSize: 28,
                                  ),
                                  const Text(
                                    'Photos',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
