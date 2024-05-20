import 'dart:typed_data';

import 'package:custom_craft/api/imageGenerator/conver_text_to_image.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/models/ai_image.dart';

class AiGenerator extends StatefulWidget {
  final Uint8List? image;

  const AiGenerator({super.key, this.image});

  @override
  State<AiGenerator> createState() => _AiGeneratorState();
}

// bool isLoading = false;
Future<void>? _future;
final TextEditingController _textOfImage = TextEditingController();

class _AiGeneratorState extends State<AiGenerator> {
  @override
  Widget build(BuildContext context) {
    var selectedAiPhoto = Provider.of<AiPhotoProvider>(context).selectedAiPhoto;
    return Scaffold(
        backgroundColor: const Color(0xffFAFAFA).withOpacity(.5),
        appBar: AppBar(
          title: const Text(
            'AI',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          centerTitle: true,
          toolbarHeight: 90,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 17, top: 13),
            child: IconButton(
              icon: const Icon(
                Icons.close_rounded,
                color: Color(0xff2E2E2E),
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(
                    context); // Navigate back when close button is pressed
              },
            ),
          ),
        ),
        body: Center(
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Create an image from text prompt',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff888888),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 24), // Add right and bottom padding
                  child: Row(
                    children: [
                      Expanded(
                        // Wrap TextField with Expanded
                        child: TextField(
                          controller: _textOfImage,
                          cursorColor: const Color(0xffD9D9D9),
                          decoration: InputDecoration(
                            //    filled: true, // Set filled to true
                            fillColor: const Color(
                                0xffD9D9D9), // Set fill color to Color(0xffD9D9D9)
                            hintText: 'Enter your prompt',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AssetsColors
                                    .primaryColor, // Set border color to AssetsColors.primaryColor
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          width:
                              8), // Add space between TextField and ElevatedButton
                      SizedBox(
                        height: 45,
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _future = convertTextToImage(
                                  _textOfImage.text, context);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AssetsColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Button border radius
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.w500, // Text weight
                            ),
                            elevation: 1, // Button elevation
                          ),
                          child: FutureBuilder<void>(
                            future: _future,
                            builder: (BuildContext context,
                                AsyncSnapshot<void> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              } else {
                                return const Text(
                                  'Generate',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
