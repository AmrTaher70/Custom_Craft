import 'package:flutter/material.dart';

class PngImage extends StatefulWidget {
  const PngImage({super.key});

  @override
  State<PngImage> createState() => _PngImageState();
}

class _PngImageState extends State<PngImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.network(
        'https://cdn0.iconfinder.com/data/icons/phosphor-fill-vol-4/256/play-fill-1024.png',
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          );
        },
      )),
    );
  }
}
