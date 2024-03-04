import 'package:custom_craft/constans/colors/colors.dart';
import 'package:flutter/material.dart';

class TextFiledData extends StatelessWidget {
  const TextFiledData({
    Key? key,
    this.title,
    required this.labelText,
    required this.controller,
    this.prefixIcon, // New parameter for prefix icon
    this.suffixIcon,
    this.readonly = false,
    this.validator,
    this.obscureText = false,
    this.togglePasswordVisibility,
    this.backgroundColor = const Color(0xffF3F3F3),
    //   this.focusColor = AssetsColors.primaryColor,
  }) : super(key: key);

  final String? title;
  final IconButton? suffixIcon;
  final IconData? prefixIcon; // New parameter for prefix icon
  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readonly;
  final bool obscureText;
  final VoidCallback? togglePasswordVisibility;
  final Color backgroundColor;
  // final Color focusColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextFormField(
          readOnly: readonly,
          controller: controller,
          validator: validator,
          style: const TextStyle(color: Colors.black),
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AssetsColors.primaryColor),
            ),
            labelText: labelText,
            //    focusColor: focusColor,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon)
                : null, // Using prefix icon if provided
            suffixIconColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.focused)
                    ? AssetsColors.primaryColor
                    : Colors.grey),
            suffixIcon: suffixIcon,
            labelStyle: TextStyle(
              color: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.focused)
                      ? AssetsColors.primaryColor
                      : Colors.grey),
            ),
            filled: true, // Set filled to true
            fillColor: backgroundColor,
          ),
        ),
      ],
    );
  }
}
