import 'package:custom_craft/core/utils/models/color_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class ColorPickerButton extends StatefulWidget {
  final Color initialColor;
  final Function(Color) onColorChanged;

  const ColorPickerButton(
      {super.key, required this.initialColor, required this.onColorChanged});

  @override
  _ColorPickerButtonState createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  late Color pickerColor;

  @override
  void initState() {
    super.initState();
    pickerColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    final colorItem = Provider.of<ColorItemModel>(context, listen: false);

    return SizedBox(
      width: 343,
      height: 37,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: pickerColor, // Background color
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
