import 'dart:typed_data';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

class SimilarityScreen extends StatefulWidget {
  final Uint8List? savedPhoto;

  const SimilarityScreen({Key? key, this.savedPhoto}) : super(key: key);

  @override
  SimilarityScreenState createState() => SimilarityScreenState();
}

class SimilarityScreenState extends State<SimilarityScreen> {
  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Similarity Screen'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 407,
                  width: 343,
                  child: Image.memory(widget.savedPhoto!)),
            ],
          ),
        ),
      ),
    );
  }
}
