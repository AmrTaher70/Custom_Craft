import 'dart:typed_data';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/models/add_photos_model.dart';
import 'package:custom_craft/core/widget/custom_app_bar_for_tools.dart';
import 'package:custom_craft/core/widget/photos.dart';
import 'package:custom_craft/features/Design/main_design.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({Key? key}) : super(key: key);

  @override
  _PhotoUploadScreenState createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  final List<Uint8List> _imageDataList = [];
  int? _selectedIndex; // Variable to keep track of the selected photo

  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Uint8List imageData = await pickedImage.readAsBytes();
      setState(() {
        _imageDataList.add(imageData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarForTools(
        onPressed: () {
          // Assuming you want to pass the last selected photo
          if (_selectedIndex != null &&
              _selectedIndex! < _imageDataList.length) {
            Uint8List selectedImageData = _imageDataList[_selectedIndex!];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MainDesign(selectedPhoto: Photo(data: selectedImageData)),
              ),
            );
          }
        },
        text: const Text(
          'Photos',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
      body: GridView.builder(
        itemCount: _imageDataList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index; // Set selected index
                });
                // Navigate to another screen with the selected photo
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         DetailScreen(imageData: _imageDataList[index]),
                //   ),
                // );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedIndex == index
                        ? AssetsColors.primaryColor
                        : Colors.transparent, // Blue border for selected photo
                    width: 3,
                  ),
                ),
                child: Image.memory(
                  _imageDataList[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AssetsColors.primaryColor,
        onPressed: _getImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
