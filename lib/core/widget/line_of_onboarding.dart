import 'package:custom_craft/core/widget/next_page_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LineOfOnBoarding extends StatefulWidget {
  const LineOfOnBoarding({super.key});

  @override
  State<LineOfOnBoarding> createState() => _LineOfOnBoardingState();
}

class _LineOfOnBoardingState extends State<LineOfOnBoarding> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: ContainerClipper(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    height: 360,
                    width: width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 6),
                      color: const Color(0xffFCFCFC).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Center(child: NextPageButton()),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ContainerClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, 50);
    var firstStart = Offset(size.width * 0.35, 50);
    var firstEnd = Offset(size.width * 0.44, 0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart = Offset(size.width * 0.45, 0);
    var secondEnd = Offset(size.width * 0.55, 0);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    var thirtStart = Offset(size.width * .66, 50);
    var thirtEnd = Offset(size.width, 50);
    path.quadraticBezierTo(
        thirtStart.dx, thirtStart.dy, thirtEnd.dx, thirtEnd.dy);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

class ContainerClipper2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, 50);
    var firstStart = Offset(size.width * 0.35, 50);
    var firstEnd = Offset(size.width * 0.44, 0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart = Offset(size.width * 0.45, 0);
    var secondEnd = Offset(size.width * 0.55, 0);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    var thirtStart = Offset(size.width * .66, 50);
    var thirtEnd = Offset(size.width, 50);
    path.quadraticBezierTo(
        thirtStart.dx, thirtStart.dy, thirtEnd.dx, thirtEnd.dy);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
