import 'package:flutter/material.dart';

class ColorItemModel extends ChangeNotifier {
  Color? color;

  void updateColor(Color newColor) {
    color = newColor;
    notifyListeners();
  }
}
