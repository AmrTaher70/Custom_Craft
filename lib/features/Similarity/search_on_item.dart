import 'dart:typed_data';
import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/utils/models/saved_photo_model.dart';
import 'package:custom_craft/core/widget/custom_app_bar_for_similarity.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/Design/main_design.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchOnItem extends StatefulWidget {
  const SearchOnItem({
    Key? key,
  }) : super(key: key);

  @override
  SearchOnItemState createState() => SearchOnItemState();
}

class SearchOnItemState extends State<SearchOnItem> {
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
                        const Text(
                          'Search for similar design with',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          'Discover personalized styles effortlessly',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8E8E8E),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                const url = 'https://lens.google.com';
                                // ignore: deprecated_member_use
                                if (await canLaunch(url)) {
                                  // ignore: deprecated_member_use
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: Image.asset(
                                  AssetsData.googleLensLogo,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            GestureDetector(
                              onTap: () async {
                                const url =
                                    'https://m.shein.com/presearch?pageType=all&pagefrom=page_home&search_button=1';
                                // ignore: deprecated_member_use
                                if (await canLaunch(url)) {
                                  // ignore: deprecated_member_use
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.black),
                                child: Image.asset(
                                  AssetsData.sheIn,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            GestureDetector(
                              onTap: () async {
                                const url = 'https://www.bing.com/visualsearch';
                                // ignore: deprecated_member_use
                                if (await canLaunch(url)) {
                                  // ignore: deprecated_member_use
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                child: Image.asset(
                                  AssetsData.bingLogo,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ),
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
