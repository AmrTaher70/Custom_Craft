import 'package:flutter/material.dart';

class TextModel extends ChangeNotifier {
  String text = '';
  Color color = Colors.red;
  TextAlign align = TextAlign.center;
  String font = 'Roboto';

  void updateText(String newText) {
    text = newText;
    notifyListeners();
  }

  void updateColor(Color newColor) {
    color = newColor;
    notifyListeners();
  }

  void updateAlign(TextAlign newAlign) {
    align = newAlign;
    notifyListeners();
  }

  void updateFont(String newFont) {
    font = newFont;
    notifyListeners();
  }
}
