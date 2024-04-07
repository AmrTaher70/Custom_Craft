// import 'package:flutter/material.dart';

// class InteractiveItem extends StatefulWidget {
//   final Widget child;

//   const InteractiveItem({super.key, required this.child});

//   @override
//   _InteractiveItemState createState() => _InteractiveItemState();
// }

// class _InteractiveItemState extends State<InteractiveItem> {
//   double _scale = 1.0;
//   Offset _position = Offset.zero;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onScaleStart: (details) {
//         // Save the initial scale and position
//         _scale = 1.0;
//         _position = details.localFocalPoint;
//       },
//       onScaleUpdate: (details) {
//         // Update the scale and position
//         setState(() {
//           _scale = details.scale;
//           _position = details.localFocalPoint;
//         });
//       },
//       child: Transform.translate(
//         offset: _position,
//         child: Transform.scale(
//           scale: _scale,
//           child: widget.child,
//         ),
//       ),
//     );
//   }
// }
