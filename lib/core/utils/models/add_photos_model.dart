import 'dart:typed_data';

import 'package:custom_craft/core/widget/photos.dart';
import 'package:flutter/material.dart';

class PhotoProvider with ChangeNotifier {
  final List<Photo> _photos = [];
  Photo? _selectedPhoto;

  List<Photo> get photos => _photos;

  // Getter for selectedPhoto
  Photo? get selectedPhoto => _selectedPhoto;

  void addPhoto(Uint8List data) {
    _photos.add(Photo(data: data));
    notifyListeners();
  }

  void setSelectedPhoto(Photo photo) {
    _selectedPhoto = photo;
    notifyListeners();
  }
}
