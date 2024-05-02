import 'dart:typed_data';

import 'package:custom_craft/core/widget/photos.dart';
import 'package:flutter/material.dart';

class AiPhotoProvider with ChangeNotifier {
  final List<Photo> _aiphotos = [];
  Photo? _selectedAiPhoto;

  List<Photo> get photos => _aiphotos;

  // Getter for selectedPhoto
  Photo? get selectedAiPhoto => _selectedAiPhoto;

  void addPhoto(Uint8List data) {
    if (data.isNotEmpty) {
      _selectedAiPhoto = Photo(data: data); // Set the selected photo
      // Optionally, you can also save it to SharedPreferences here
      notifyListeners();
    }
  }
}
