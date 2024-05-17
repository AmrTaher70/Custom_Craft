import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/helper/api.helper.dart';
import 'package:flutter/material.dart';
// Import the Api helper

class ShapeProvider extends ChangeNotifier {
  List<String> _shapes = [];
  String? _selectedShape;
  Color _selectedColor = AssetsColors.primaryColor;

  List<String> get shapes => _shapes;
  String? get selectedShape => _selectedShape;
  Color get selectedColor => _selectedColor;

  Future<void> fetchShapes() async {
    final api = Api(); // Instantiate the Api helper
    const url = 'http://customcrafttt.somee.com/api/Shape/GetShapes';
    try {
      final response = await api.get(url: url);
      if (response is List<dynamic>) {
        final List<String> shapeUrls = response
            .map((shapeData) => shapeData['pictureUrl'].toString())
            .toList();
        _shapes = shapeUrls;
        notifyListeners();
      } else {
        throw Exception('Failed to load shapes');
      }
    } catch (e) {
      throw Exception('Failed to fetch shapes: $e');
    }
  }

  void setSelectedShape(String? shape) {
    _selectedShape = shape;
    notifyListeners();
  }

  void setSelectedColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }
}
