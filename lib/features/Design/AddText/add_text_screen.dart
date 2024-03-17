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
                        textAlign: TextAlign.center,
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
