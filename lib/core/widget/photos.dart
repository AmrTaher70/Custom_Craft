import 'dart:typed_data';

class Photo {
  final Uint8List data;
  bool isSelected;

  Photo({required this.data, this.isSelected = false});
}
