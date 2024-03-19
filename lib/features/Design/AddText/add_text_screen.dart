import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/widget/color_picker.dart';
import 'package:custom_craft/core/widget/custom_app_bar_for_tools.dart';
import 'package:custom_craft/core/widget/font_selector.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddText extends StatefulWidget {
  const AddText({Key? key}) : super(key: key);

  @override
  _AddTextState createState() => _AddTextState();
}

class _AddTextState extends State<AddText> {
  late TextEditingController _textControllerOfAddText;
  String dropdownValue = 'Roboto';
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  TextAlign textAlign = TextAlign.center;
  int selectedIcon = 0; // Added

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    super.initState();
    _textControllerOfAddText = TextEditingController();
  }

  @override
  void dispose() {
    _textControllerOfAddText.dispose();
    super.dispose();
  }

  Color iconColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA).withOpacity(.5),
      appBar: const CustomAppBarForTools(
        text: Text(
          'Text',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
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
                      child: TextField(
                        textAlign: textAlign, // Updated
                        controller: _textControllerOfAddText,
                        style: GoogleFonts.getFont(
                          dropdownValue,
                          fontSize: 48.0,
                          color: currentColor,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Text',
                          hintStyle: GoogleFonts.getFont(
                            dropdownValue,
                            fontSize: 48.0,
                            color: currentColor,
                          ),
                          border: InputBorder.none,
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: FontSelector(
                        onFontChanged: (String font) {
                          setState(() {
                            dropdownValue = font;
                          });
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
                        setState(() {
                          textAlign = TextAlign.left;
                          selectedIcon = 1; // Change this line
                        });
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
                      setState(() {
                        textAlign = TextAlign.center;
                        selectedIcon = 2; // Change this line
                      });
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
                        setState(() {
                          textAlign = TextAlign.right;
                          selectedIcon = 3; // Change this line
                        });
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
