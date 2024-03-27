import 'package:flutter/material.dart';

class ColorItemModel extends ChangeNotifier {
  Color? color;

  List<Color> usedColors = [];
  Color? colorOfItem;

  void updateUsedColor(Color newColor) {
    usedColors.add(newColor);
    notifyListeners();
  }

  void updateColor(Color newColor) {
    colorOfItem = newColor;
    notifyListeners();
  }
}
