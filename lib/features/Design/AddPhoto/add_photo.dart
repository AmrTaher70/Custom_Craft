import 'dart:typed_data';

import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/models/add_photos_model.dart';
import 'package:custom_craft/core/widget/customappbarforaddphoto%20.dart';
import 'package:custom_craft/features/Design/Main/main_design.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({Key? key}) : super(key: key);

  @override
  _PhotoUploadScreenState createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  // final List<Uint8List> _imageDataList = [];
  // int? _selectedIndex; // Variable to keep track of the selected photo

  Future<void> _getImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Uint8List imageData = await pickedImage.readAsBytes();
      // ignore: use_build_context_synchronously
      Provider.of<PhotoProvider>(context, listen: false).addPhoto(imageData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA).withOpacity(.5),
      appBar: CustomAppBarForAddPhoto(
        onPressed: () {
          // Check if a photo is selected
          // if (_selectedIndex != null &&
          //     _selectedIndex! < _imageDataList.length) {
          //   // Pass the selected photo back to the previous screen
          //   Uint8List selectedImageData = _imageDataList[_selectedIndex!];
          // Call the callback function with the selected photo
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainDesign()),
          );
          // }
        },
        title: 'Photos',
        // style: TextStyle(fontSize: 24, color: Colors.black),
      ),
      body: Consumer<PhotoProvider>(
        builder: (context, photoProvider, _) {
          return GridView.builder(
            itemCount: photoProvider.photos.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (photoProvider.selectedPhoto ==
                      photoProvider.photos[index]) {
                    photoProvider.setSelectedPhoto(
                        null); // Deselect the photo if it's already selected
                  } else {
                    photoProvider.setSelectedPhoto(photoProvider.photos[
                        index]); // Select the photo if it's not already selected
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: photoProvider.selectedPhoto ==
                              photoProvider.photos[index]
                          ? AssetsColors.primaryColor
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: Image.memory(
                    photoProvider.photos[index].data,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _getImage(context),
        backgroundColor: AssetsColors.primaryColor,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
