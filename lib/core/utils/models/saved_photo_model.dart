import 'dart:typed_data';
import 'package:flutter/material.dart';

class SavedImageModel extends ChangeNotifier {
  final List<Uint8List?> _savedImages = [];

  List<Uint8List?> get savedImages => _savedImages;

  void saveImage(Uint8List? image) {
    _savedImages.add(image);
    notifyListeners();
  }
}
