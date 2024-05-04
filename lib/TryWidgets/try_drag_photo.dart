import 'package:flutter/material.dart';

class ResizableDraggableImage extends StatefulWidget {
  final String imageUrl;
  final double initialWidth;
  final double initialHeight;

  const ResizableDraggableImage({
    Key? key,
    required this.imageUrl,
    this.initialWidth = 100.0,
    this.initialHeight = 100.0,
  }) : super(key: key);

  @override
  State<ResizableDraggableImage> createState() =>
      _ResizableDraggableImageState();
}

class _ResizableDraggableImageState extends State<ResizableDraggableImage> {
  final double _width = 0.0;
  final double _height = 0.0;
  double _top = 0.0;
  double _left = 0.0;
  final double _scale = 1.0;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _left += details.delta.dx;
      _top += details.delta.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onPanUpdate: _onPanUpdate,
        child: Container(
          width: _width * _scale,
          height: _height * _scale,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: const DecorationImage(
              image: NetworkImage(
                  'https://cdn0.iconfinder.com/data/icons/phosphor-fill-vol-4/256/play-fill-1024.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
