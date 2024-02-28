import 'package:flutter/material.dart';

class HorizontalLine extends StatelessWidget {
  final double lineWidth;
  final Color lineColor;

  const HorizontalLine(
      {super.key, required this.lineWidth, required this.lineColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: lineWidth,
        color: lineColor,
      ),
    );
  }
}
