import 'dart:typed_data';
import 'package:flutter/material.dart';

class SavedImageModel extends ChangeNotifier {
  final List<Uint8List?> _savedImages = [];
  Uint8List? _lastAccessedImage;

  List<Uint8List?> get savedImages => _savedImages;
  Uint8List? get lastAccessedImage => _lastAccessedImage;

  void saveImage(Uint8List? image) {
    _savedImages.add(image);
    _lastAccessedImage = image;
    notifyListeners();
  }

  void setLastAccessedImage(Uint8List? image) {
    _lastAccessedImage = image;
    notifyListeners();
  }

  void removeImage(int index) {
    _savedImages.removeAt(index);
    notifyListeners();
  }
}
