// ignore_for_file: library_private_types_in_public_api

import 'package:custom_craft/core/utils/models/color_item_model.dart';
import 'package:custom_craft/core/widget/color_picker.dart';
import 'package:custom_craft/core/widget/custom_app_bar_for_tools.dart';
import 'package:custom_craft/features/Design/main_design.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseColor extends StatefulWidget {
  const ChooseColor({
    Key? key,
  }) : super(key: key);

  @override
  _ChooseColorState createState() => _ChooseColorState();
}

class _ChooseColorState extends State<ChooseColor> {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  Color iconColor = Colors.grey;
  void changeColor(BuildContext context, Color color) {
    setState(() => pickerColor = color);
    Provider.of<ColorItemModel>(context, listen: false).updateColor(color);
  }

  @override
  Widget build(BuildContext context) {
    final colorItem = Provider.of<ColorItemModel>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA).withOpacity(.5),
      appBar: CustomAppBarForTools(
        text: const Text(
          'Color',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        onPressed: () {
          colorItem.updateColor(currentColor);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainDesign()),
          );
        },
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColorPickerButton(
              initialColor: currentColor,
              onColorChanged: (Color color) {
                changeColor(context, color); // Pass the context here
                setState(() => currentColor = color);
              },
            ),
          ],
        ),
      ),
    );
  }
}
