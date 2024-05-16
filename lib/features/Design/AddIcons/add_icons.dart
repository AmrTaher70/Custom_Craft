import 'package:custom_craft/api/get_icons_model/get_icons_model.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/widget/color_picker.dart';
import 'package:custom_craft/core/widget/custom_app_bar_for_tools.dart';
import 'package:custom_craft/features/Design/MainDesign/main_design.dart';
import 'package:custom_craft/helper/api.helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconProvider extends ChangeNotifier {
  final List<String> _icons = [];
  late Api _api;

  IconProvider() {
    _api = Api();
    _fetchIcons();
  }

  Future<void> _fetchIcons() async {
    try {
      final dynamic response = await _api.get(
          url: 'http://customcraftt.somee.com/api/Icon/GetIcons');
      if (response != null && response is List<dynamic>) {
        final List<GetIconsModel> newIcons =
            response.map((item) => GetIconsModel.fromJson(item)).toList();
        // Replace the existing icons with the new ones
        _icons.clear();
        for (var icon in newIcons) {
          _icons.add(icon.pictureUrl!);
        }
        print('Icons updated successfully.');
      } else {
        print('Failed to update icons. Invalid response from the API.');
      }
    } catch (e) {
      print('Failed to fetch icons: $e');
    }
  }

  String? _selectedIcons;
  Color _selectedColor = AssetsColors.primaryColor;

  List<String> get icons => _icons;
  String? get selectedIcon => _selectedIcons;
  Color get selectedColor => _selectedColor;

  void setSelectedIcons(String? icons) {
    _selectedIcons = icons;
    notifyListeners();
  }

  void setSelectedColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }
}

class AddIcon extends StatefulWidget {
  const AddIcon({Key? key}) : super(key: key);

  @override
  State<AddIcon> createState() => _AddIconState();
}

class _AddIconState extends State<AddIcon> {
  int? selectedIconsIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA).withOpacity(.5),
      appBar: CustomAppBarForTools(
        text: const Text(
          'Icons',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainDesign()),
          );
        },
      ),
      body: Consumer<IconProvider>(
        builder: (context, iconProvider, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iconProvider.selectedIcon != null
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
                          child: Image.network(
                            'http//customcraftt.somee.com/images/icons/emojione-monotone_deer.png',
                            // height: 270,
                            // width: 270,
                            // fit: BoxFit.cover,
                            color: iconProvider.selectedColor,
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
                      'Icon Color',
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
                    initialColor: iconProvider.selectedColor,
                    onColorChanged: (Color color) {
                      iconProvider.setSelectedColor(color);
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                    child: GridView.builder(
                  itemCount: iconProvider.icons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (selectedIconsIndex == index) {
                          selectedIconsIndex =
                              null; // Deselect the shape if it's already selected
                        } else {
                          selectedIconsIndex =
                              index; // Select the shape if it's not already selected
                        }
                        iconProvider.setSelectedIcons(
                            iconProvider.icons[selectedIconsIndex!]);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: selectedIconsIndex == index
                                ? AssetsColors
                                    .primaryColor // Border color for selected shape
                                : Colors.transparent,
                          ),
                        ),
                        child: Image.network(
                          iconProvider.icons[index],
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          color: selectedIconsIndex == index
                              ? iconProvider.selectedColor
                              : null,
                          colorBlendMode: selectedIconsIndex == index
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
