// ignore_for_file: library_private_types_in_public_api

import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/models/text_model.dart';
import 'package:custom_craft/core/widget/add_text_on_photo.dart';
import 'package:custom_craft/core/widget/color_picker.dart';
import 'package:custom_craft/core/widget/custom_app_bar_for_tools.dart';
import 'package:custom_craft/core/widget/font_selector.dart';
import 'package:custom_craft/features/Design/MainDesign/main_design.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddText extends StatefulWidget {
  const AddText({
    Key? key,
    required this.initialText,
    required this.initialFont,
    required this.initialColor,
    required this.initialAlign,
  }) : super(key: key);

  @override
  _AddTextState createState() => _AddTextState();
  final String initialText;
  final String initialFont;
  final Color initialColor;
  final TextAlign initialAlign;
}

class _AddTextState extends State<AddText> {
  late final TextEditingController _textControllerOfAddText;
  String dropdownValue = 'Bitter';
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  TextAlign textAlign = TextAlign.center;
  int selectedIcon = 0;

  @override
  void initState() {
    super.initState();
    _textControllerOfAddText = TextEditingController(text: widget.initialText);
    dropdownValue = widget.initialFont;
    currentColor = widget.initialColor;
    textAlign = widget.initialAlign;
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
    Provider.of<TextModel>(context, listen: false).updateColor(color);
  }

  void changeText(String text) {
    Provider.of<TextModel>(context, listen: false).updateText(text);
  }

  void changeAlign(TextAlign align) {
    setState(() => textAlign = align);
    Provider.of<TextModel>(context, listen: false).updateAlign(align);
  }

  void changeFont(String font) {
    setState(() => dropdownValue = font);
    Provider.of<TextModel>(context, listen: false).updateFont(font);
  }

  @override
  void dispose() {
    _textControllerOfAddText.dispose();
    super.dispose();
  }

  Color iconColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    final textModel = Provider.of<TextModel>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA).withOpacity(.5),
      appBar: CustomAppBarForTools(
        text: const Text(
          'Text',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        onPressed: () {
          textModel.updateText(_textControllerOfAddText.text);
          textModel.updateColor(currentColor);
          textModel.updateAlign(textAlign);
          textModel.updateFont(dropdownValue);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MainDesign(
                      frontImage: '',
                      backImage: '',
                    )),
          );
        },
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 343,
              height: 356,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 122),
                      child: MyTextField(
                        textControllerOfAddText: _textControllerOfAddText,
                        textAlign: textAlign,
                        dropdownValue: dropdownValue,
                        currentColor: currentColor,
                      ),
                    ),
                    Center(
                      child: FontSelector(
                        onFontChanged: (String font) {
                          setState(
                            () {
                              dropdownValue = font;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            Container(
              width: 343,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xffD3D3D3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                // Added
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            textAlign = TextAlign.left;
                            selectedIcon = 1; // Change this line
                          },
                        );
                      },
                      icon: Icon(
                        Icons.align_horizontal_left_outlined,
                        color: selectedIcon == 1
                            ? AssetsColors.primaryColor
                            : Colors.grey, // Change this line
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          textAlign = TextAlign.center;
                          selectedIcon = 2; // Change this line
                        },
                      );
                    },
                    icon: Icon(
                      Icons.align_horizontal_center_outlined,
                      color: selectedIcon == 2
                          ? AssetsColors.primaryColor
                          : Colors.grey, // Change this line
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            textAlign = TextAlign.right;
                            selectedIcon = 3; // Change this line
                          },
                        );
                      },
                      icon: Icon(
                        Icons.align_horizontal_right_outlined,
                        color: selectedIcon == 3
                            ? AssetsColors.primaryColor
                            : Colors.grey, // Change this line
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 1,
              width: 343,
              color: const Color(0xff8E8E8E),
            ),
            const SizedBox(
              height: 16,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 24),
                child: Text(
                  'Text Color',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ColorPickerButton(
              initialColor: currentColor,
              onColorChanged: (Color color) {
                setState(() => currentColor = color);
              },
            ),
          ],
        ),
      ),
    );
  }
}
