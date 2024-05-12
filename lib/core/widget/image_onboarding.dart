import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BackGroundOfOnBoarding extends StatefulWidget {
  const BackGroundOfOnBoarding({super.key, required this.child});

  @override
  State<BackGroundOfOnBoarding> createState() => _BackGroundOfOnBoardingState();
  final Widget child;
}

class _BackGroundOfOnBoardingState extends State<BackGroundOfOnBoarding> {
  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;
    //final double width = screenSize.width;
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Image.asset(AssetsData.BackGroundOfBoarding)],
        ),
        widget.child
      ],
    );
  }
}

// class ContainerClipper extends CustomClipper<Path> {
//   @override
//   getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, 50);
//     var firstStart = Offset(size.width * 0.35, 50);
//     var firstEnd = Offset(size.width * 0.44, 0);
//     path.quadraticBezierTo(
//         firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
//     var secondStart = Offset(size.width * 0.45, 0);
//     var secondEnd = Offset(size.width * 0.55, 0);
//     path.quadraticBezierTo(
//         secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
//     var thirtStart = Offset(size.width * .66, 50);
//     var thirtEnd = Offset(size.width, 50);
//     path.quadraticBezierTo(
//         thirtStart.dx, thirtStart.dy, thirtEnd.dx, thirtEnd.dy);
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper oldClipper) => true;
// }

// class ContainerClipper2 extends CustomClipper<Path> {
//   @override
//   getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, 50);
//     var firstStart = Offset(size.width * 0.35, 50);
//     var firstEnd = Offset(size.width * 0.44, 0);
//     path.quadraticBezierTo(
//         firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
//     var secondStart = Offset(size.width * 0.45, 0);
//     var secondEnd = Offset(size.width * 0.55, 0);
//     path.quadraticBezierTo(
//         secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
//     var thirtStart = Offset(size.width * .66, 50);
//     var thirtEnd = Offset(size.width, 50);
//     path.quadraticBezierTo(
//         thirtStart.dx, thirtStart.dy, thirtEnd.dx, thirtEnd.dy);
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper oldClipper) => true;
// }
