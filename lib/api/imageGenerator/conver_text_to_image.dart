// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:custom_craft/core/utils/models/ai_image.dart';
import 'package:custom_craft/features/Design/MainDesign/main_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void showErrorDialog(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<dynamic> convertTextToImage(
  String prompt,
  BuildContext context,
) async {
  Uint8List imageData = Uint8List(0);
  Provider.of<AiPhotoProvider>(context, listen: false).addPhoto(imageData);
  const baseUrl = 'https://api.stability.ai';
  final url = Uri.parse(
      '$baseUrl/v1alpha/generation/stable-diffusion-512-v2-1/text-to-image');

  // Make the HTTP POST request to the Stability Platform API
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization':
          //add ypur secreat key here
          'Bearer sk-VAb6H7zj93P4hqwAzPzqCucMmhVFQ8KziSmirXuPDCiLAH85',
      'Accept': 'image/png',
    },
    body: jsonEncode({
      'cfg_scale': 15,
      'clip_guidance_preset': 'FAST_BLUE',
      'height': 512,
      'width': 512,
      'samples': 1,
      'steps': 150,
      'seed': 0,
      'style_preset': "sd3",
      'text_prompts': [
        {
          'text': prompt,
          'weight': 1,
        }
      ],
    }),
  );

  if (response.statusCode == 200) {
    try {
      imageData = response.bodyBytes;
      Provider.of<AiPhotoProvider>(context, listen: false).addPhoto(imageData);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainDesign(
              image: imageData,
              frontImage: '',
              backImage: '',
            ),
          ));
      return imageData;
    } catch (e) {
      showErrorDialog('Failed to decode image', context);
      return null; // Return null to indicate error
    }
  } else {
    showErrorDialog('Failed to generate image', context);
    return null; // Return null to indicate error
  }
}
