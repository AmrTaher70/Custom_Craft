import 'package:flutter/material.dart';

class ItemPhotosProvider extends ChangeNotifier {
  String? _selectedFrontPhoto;
  String? _selectedBackPhoto;

  String? get selectedFrontPhoto => _selectedFrontPhoto;
  String? get selectedBackPhoto => _selectedBackPhoto;

  void setSelectedPhotos(String frontPhoto, String backPhoto) {
    _selectedFrontPhoto = frontPhoto;
    _selectedBackPhoto = backPhoto;
    notifyListeners();
  }
}
