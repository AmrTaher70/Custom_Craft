import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.text, this.leading})
      : super(key: key);
  final Text text;
  final Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(62);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 3, color: Colors.white),
        ),
      ),
      child: AppBar(
        centerTitle: true,
        toolbarHeight: 72,
        elevation: 0,
        title: text,
        backgroundColor: const Color(0xffFAFAFA).withOpacity(.6),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: leading,
        ),
      ),
    );
  }
}
