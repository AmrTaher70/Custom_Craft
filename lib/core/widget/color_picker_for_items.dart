import 'package:custom_craft/core/utils/models/color_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class ColorPickerFotItemButton extends StatefulWidget {
  final Color initialColor;
  final Function(Color) onColorChanged;

  const ColorPickerFotItemButton(
      {super.key, required this.initialColor, required this.onColorChanged});

  @override
  _ColorPickerFotItemButtonState createState() =>
      _ColorPickerFotItemButtonState();
}

class _ColorPickerFotItemButtonState extends State<ColorPickerFotItemButton> {
  late Color pickerColor;
  Color currentColor = const Color(0xff443a49);

  @override
  void initState() {
    super.initState();
    pickerColor = currentColor;
  }

  @override
  Widget build(BuildContext context) {
    final colorItem = Provider.of<ColorItemModel>(context, listen: false);

    return SizedBox(
      width: 343,
      height: 37,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorItem.colorOfItem, // Background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6), // Button border radius
          ),
          elevation: 1, // Button elevation
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Pick a color!'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: pickerColor,
                    onColorChanged: (Color color) {
                      setState(() => pickerColor = color);
                      widget.onColorChanged(color);
                    },
                    labelTypes: const [],
                    pickerAreaHeightPercent: 0.8,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Got it'),
                    onPressed: () {
                      setState(() {
                        colorItem.colorOfItem =
                            pickerColor; // Set the current color to the selected color
                      });
                      colorItem.updateColor(pickerColor);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: null,
      ),
    );
  }
}
