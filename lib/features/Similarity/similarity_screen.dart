import 'dart:typed_data';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/utils/models/saved_photo_model.dart';
import 'package:custom_craft/core/widget/custom_app_bar_for_similarity.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/Design/main_design.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SimilarityScreen extends StatefulWidget {
  const SimilarityScreen({
    Key? key,
  }) : super(key: key);

  @override
  SimilarityScreenState createState() => SimilarityScreenState();
}

class SimilarityScreenState extends State<SimilarityScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;
    List<Uint8List?> savedPhotos =
        Provider.of<SavedImageModel>(context).savedImages;
    return BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBarForSimilarity(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainDesign()),
            );
          },
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      AssetsData.BackGroundOfItem,
                      width: width,
                      height: 560,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: savedPhotos.isNotEmpty
                          ? Image.memory(
                              savedPhotos.last!,
                              height: 407,
                              width: 343,
                              fit: BoxFit.fitHeight,
                            )
                          : const Text('No saved photo'),
                    ),
                  ],
                ),
              ),
              Container(
                  width: width - 10,
                  height: height * 0.24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 3, color: Colors.white),
                    color: const Color(0xffFAFAFA).withOpacity(.4),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.keyboard_control_key_outlined,
                          ),
                          onPressed: () {
                            // Your onPressed callback
                          },
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                'Search for similar design',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: SizedBox(
                                height: 40,
                                width: 98,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AssetsColors
                                        .primaryColor, // Background color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Button border radius
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 16, // Text size
                                      fontWeight:
                                          FontWeight.w400, // Text weight
                                    ),
                                    elevation: 1, // Button elevation
                                  ),
                                  onPressed: () {},
                                  child: const FittedBox(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Search',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.search_outlined,
                                          size: 19,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

 // savedPhoto != null
              //     ? Image.memory(savedPhoto)
              //     : const Text('No saved photo'),