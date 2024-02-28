import 'package:flutter/material.dart';

class TextFiledData extends StatelessWidget {
  const TextFiledData({
    Key? key,
    this.title,
    required this.hintTitle,
    required this.controller,
    this.prefixIcon, // New parameter for prefix icon
    this.suffixIcon,
    this.readonly = false,
    this.validator,
    this.obscureText = false,
    this.togglePasswordVisibility,
    this.backgroundColor = const Color(0xffF3F3F3),
  }) : super(key: key);

  final String? title;
  final IconButton? suffixIcon;
  final IconData? prefixIcon; // New parameter for prefix icon
  final String hintTitle;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readonly;
  final bool obscureText;
  final VoidCallback? togglePasswordVisibility;
  final Color backgroundColor;

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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            hintText: hintTitle,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon)
                : null, // Using prefix icon if provided
            suffixIcon: suffixIcon,
            filled: true, // Set filled to true
            fillColor: backgroundColor,
          ),
        ),
      ],
    );
  }
}
