import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:custom_craft/core/widget/color_picker.dart';
import 'package:custom_craft/core/widget/custom_app_bar_for_tools.dart';
import 'package:custom_craft/features/Design/main_design.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShapeProvider extends ChangeNotifier {
  final List<String> _shapes = <String>[
    AssetsData.circle,
    AssetsData.circle,
    AssetsData.circle,
    AssetsData.circle,
    AssetsData.circle,
    AssetsData.circle,
    AssetsData.circle,
    AssetsData.circle
  ]; // Fill the list with 16 hoodie images
  String? _selectedShape;
  Color _selectedColor =
      AssetsColors.primaryColor; // Initialize with a default color

  List<String> get shapes => _shapes;
  String? get selectedShape => _selectedShape;
  Color get selectedColor => _selectedColor;

  void setSelectedShape(String? shape) {
    _selectedShape = shape;
    notifyListeners();
  }

  void setSelectedColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }
}

class AddShape extends StatefulWidget {
  const AddShape({Key? key}) : super(key: key);

  @override
  State<AddShape> createState() => _AddShapeState();
}

class _AddShapeState extends State<AddShape> {
  @override
  Widget build(BuildContext context) {
    int? selectedShapeIndex;
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA).withOpacity(.5),
      appBar: CustomAppBarForTools(
        text: const Text(
          'Shapes',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainDesign()),
          );
        },
      ),
      body: Consumer<ShapeProvider>(
        builder: (context, shapeProvider, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                shapeProvider.selectedShape != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 343,
                          height: 356,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xff8E8E8E),
                            ),
                          ),
                          child: Image.asset(
                            shapeProvider.selectedShape!,
                            height: 160,
                            width: 160,
                            // fit: BoxFit.cover,
                            color: shapeProvider.selectedColor,
                            colorBlendMode: BlendMode.modulate,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 343,
                          height: 356,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xff8E8E8E),
                            ),
                          ),
                        )),
                const SizedBox(
                  height: 16,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Text(
                      'Shape Color',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: ColorPickerButton(
                    initialColor: shapeProvider.selectedColor,
                    onColorChanged: (Color color) {
                      shapeProvider.setSelectedColor(color);
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                    child: GridView.builder(
                  itemCount: shapeProvider.shapes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (selectedShapeIndex == index) {
                          selectedShapeIndex =
                              null; // Deselect the shape if it's already selected
                        } else {
                          selectedShapeIndex =
                              index; // Select the shape if it's not already selected
                        }
                        shapeProvider.setSelectedShape(
                            shapeProvider.shapes[selectedShapeIndex!]);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: selectedShapeIndex == index
                                ? AssetsColors
                                    .primaryColor // Border color for selected shape
                                : Colors.transparent,
                          ),
                        ),
                        child: Image.asset(
                          shapeProvider.shapes[index],
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          color: selectedShapeIndex == index
                              ? shapeProvider.selectedColor
                              : null,
                          colorBlendMode: selectedShapeIndex == index
                              ? BlendMode.modulate
                              : null,
                        ),
                      ),
                    );
                  },
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
