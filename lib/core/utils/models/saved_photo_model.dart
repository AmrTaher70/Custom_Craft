import 'dart:typed_data';

import 'package:flutter/material.dart';

class SavedImageModel extends ChangeNotifier {
  Uint8List? _savedImage;

  Uint8List? get savedImage => _savedImage;

  void saveImage(Uint8List? image) {
    _savedImage = image;
    notifyListeners();
  }
}
