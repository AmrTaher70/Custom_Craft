import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:custom_craft/core/widget/photos.dart';

class SavedPhotoProvider with ChangeNotifier {
  final List<Photo> _photos = [];
  Photo? _savedPhoto;

  List<Photo> get photos => _photos;

  // Getter for selectedPhoto
  Photo? get selectedPhoto => _savedPhoto;

  void addPhoto(Uint8List data) {
    // Check if the same photo already exists in the list
    if (!_photos.any((photo) => photo.data == data)) {
      _photos.add(Photo(data: data));
      notifyListeners();
    } else {
      // Optionally handle the case where the photo already exists
      print('Duplicate photo detected!');
    }
  }

  void setSelectedPhoto(Photo? photo) {
    _savedPhoto = photo;
    notifyListeners();
  }
}
