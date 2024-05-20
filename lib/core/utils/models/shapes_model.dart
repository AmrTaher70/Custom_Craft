import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:flutter/material.dart';

class ShapeProvider extends ChangeNotifier {
  final List<String> _shapes = List<String>.filled(
      16, AssetsData.shape1); // Fill the list with 16 hoodie images
  String? _selectedShape;
  Color _selectedColor =
      const Color.fromARGB(255, 12, 151, 83); // Initialize with a default color

  List<String> get shapes => _shapes;
  String? get selectedShape => _selectedShape;
  Color get selectedColor => _selectedColor;

  void setSelectedShape(String? shape) {
    _selectedShape = shape;
    notifyListeners();
  }

  void setSelectedColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }
}
