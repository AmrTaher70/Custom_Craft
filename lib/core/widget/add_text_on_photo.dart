import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textControllerOfAddText;
  final TextAlign textAlign;
  final String dropdownValue;
  final Color currentColor;

  const MyTextField({
    super.key,
    required this.textControllerOfAddText,
    required this.textAlign,
    required this.dropdownValue,
    required this.currentColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: textAlign,
      controller: textControllerOfAddText,
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
    );
  }
}
