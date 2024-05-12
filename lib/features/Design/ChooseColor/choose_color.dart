import 'package:custom_craft/core/utils/models/color_item_model.dart';
import 'package:custom_craft/core/widget/color_picker_for_items.dart';
import 'package:custom_craft/core/widget/custom_app_bar_for_tools.dart';
import 'package:custom_craft/features/Design/Main/main_design.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseColor extends StatefulWidget {
  const ChooseColor({
    Key? key,
  }) : super(key: key);

  @override
  _ChooseColorState createState() => _ChooseColorState();
}

class _ChooseColorState extends State<ChooseColor> {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  Color iconColor = Colors.grey;
  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorItem = Provider.of<ColorItemModel>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA).withOpacity(.5),
      appBar: CustomAppBarForTools(
        text: const Text(
          'Color',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        onPressed: () {
          setState(() {
            currentColor =
                pickerColor; // Set the current color to the selected color
          });
          colorItem.updateColor(currentColor);
          colorItem.updateUsedColor(
              currentColor); // Add the selected color to the list of used colors
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainDesign()),
          );
        },
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 24),
                child: Text(
                  'Pick Color',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ColorPickerFotItemButton(
              initialColor: currentColor,
              onColorChanged: (Color color) {
                changeColor(color);
              },
            ),
            const SizedBox(height: 16),
            Container(
              height: 1,
              width: 343,
              color: const Color(0xff8E8E8E),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Used Colors',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: SizedBox(
                height: 42,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colorItem.usedColors.length,
                  itemBuilder: (context, index) {
                    final color = colorItem.usedColors[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentColor =
                                color; // Change the current color to the selected color
                            pickerColor =
                                color; // Update the picker color as well
                          });
                          colorItem.updateColor(
                              color); // Update the color of the item
                        },
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
