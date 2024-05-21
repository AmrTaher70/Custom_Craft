// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:universal_html/html.dart' as html;
import 'package:custom_craft/core/utils/models/ai_image.dart';
import 'package:custom_craft/core/utils/models/saved_photo_model.dart';
import 'package:custom_craft/features/Similarity/search_on_item.dart';
import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:custom_craft/core/utils/models/add_photos_model.dart';
import 'package:custom_craft/core/utils/models/color_item_model.dart';
import 'package:custom_craft/features/Design/AddIcons/add_icons.dart';
import 'package:custom_craft/features/Design/AddPhoto/add_photo.dart';
import 'package:custom_craft/core/widget/custom_app_bar_for_design.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/photos.dart';
import 'package:custom_craft/features/Design/AddText/add_text_screen.dart';
import 'package:custom_craft/features/Design/AiGenerator/ai_generator.dart';
import 'package:custom_craft/features/Design/ChooseColor/choose_color.dart';
import 'package:custom_craft/features/Design/Shapes/add_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/models/text_model.dart';

class MainDesign extends StatefulWidget {
  const MainDesign({
    Key? key,
    this.selectedPhoto,
    this.image,
    required this.frontImage,
    required this.backImage,
  }) : super(key: key);
  final Photo? selectedPhoto;
  final Uint8List? image;
  final String frontImage;
  final String backImage;

  @override
  State<MainDesign> createState() => _MainDesignState();
}

class _MainDesignState extends State<MainDesign> {
  final GlobalKey _designKey = GlobalKey();
  final PageController _pageController = PageController(viewportFraction: 0.2);
  final TransformationController _controller = TransformationController();
  final TransformationController _controllerIcon = TransformationController();
  final TransformationController _controllerShape = TransformationController();
  final TransformationController _controllerImage = TransformationController();
  int _currentPageIndex = 0;
  late List<String> images;

  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  // final Offset _position = const Offset(0, 0);

  @override
  void initState() {
    super.initState();
    images = [widget.frontImage, widget.backImage];
    _loadStateForText();
    _loadStateForIcons();
    _loadStateForShape();
    _loadStateForImage();
    _pageController.addListener(_handlePageChange);
  }

  Future<void> _loadState(
      String key, TransformationController controller) async {
    // Retrieve matrix data from local storage
    final jsonString = window.localStorage[key];
    if (jsonString != null) {
      final List<dynamic> list = json.decode(jsonString);
      final List<double> matrixList =
          list.map<double>((value) => value.toDouble()).toList();
      final Matrix4 matrix = Matrix4.fromList(matrixList);
      controller.value = matrix;
    }
  }

  Future<void> _saveState(
      String key, TransformationController controller) async {
    // Save matrix data to local storage
    final List<double> matrixList = controller.value.storage.toList();
    final jsonString = json.encode(matrixList);
    window.localStorage[key] = jsonString;
  }

// Usage of the above functions for specific transformations
  Future<void> _saveStateForText() async {
    await _saveState('matrix_text', _controller);
  }

  Future<void> _saveStateForIcons() async {
    await _saveState('matrix_icons', _controller);
  }

  Future<void> _saveStateForShape() async {
    await _saveState('matrix_shape', _controller);
  }

  Future<void> _saveStateForImage() async {
    await _saveState('matrix_image', _controller);
  }

  Future<void> _loadStateForText() async {
    await _loadState('matrix_text', _controller);
  }

  Future<void> _loadStateForIcons() async {
    await _loadState('matrix_icons', _controller);
  }

  Future<void> _loadStateForShape() async {
    await _loadState('matrix_shape', _controller);
  }

  Future<void> _loadStateForImage() async {
    await _loadState('matrix_image', _controller);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlePageChange() {
    setState(() {
      _currentPageIndex = _pageController.page!.round();
    });
  }

  void handleVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _fontSize = (_fontSize + details.delta.dy).clamp(5, 55);
    });
  }

  double _fontSize = 30.0;

  double _calculateBoundaryMargin() {
    // Calculate the boundary margin based on font size
    // Ensure that the maximum vertical margin is 100
    double margin = 200 - (_fontSize / 2);
    return margin.clamp(0, 100); // Clamp the value between 0 and 100
  }

  Future<Uint8List?> _captureDesign() async {
    try {
      RenderRepaintBoundary boundary = _designKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      double pixelRatio = window.devicePixelRatio as double; // Cast to double
      print("Pixel Ratio: $pixelRatio");

      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print("Error capturing design: $e");
      return null;
    }
  }

  Future<Uint8List?> _saveDesign() async {
    print("Saving design...");
    try {
      Uint8List? designImage = await _captureDesign();
      if (designImage != null) {
        final blob = html.Blob([designImage]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute("download", "design_image.png")
          ..click();
        html.Url.revokeObjectUrl(url);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Design saved')),
        );
        Provider.of<SavedImageModel>(context, listen: false)
            .saveImage(designImage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save design')),
        );
      }
    } catch (e) {
      print("Error saving design: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save design')),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    // final double hight = screenSize.height;
    final textModel = Provider.of<TextModel>(context);
    final colorItemModel = Provider.of<ColorItemModel>(context);
    final text = textModel.text;
    final color = textModel.color;
    final align = textModel.align;
    final font = textModel.font;
    var selectedPhoto = Provider.of<PhotoProvider>(context).selectedPhoto;
    var selectedAiPhoto = Provider.of<AiPhotoProvider>(context).selectedAiPhoto;
    final selectedShape = Provider.of<ShapeProvider>(context).selectedShape;
    final selectedColor = Provider.of<ShapeProvider>(context).selectedColor;
    var selectedIcons = Provider.of<IconProvider>(context).selectedIcon;
    final selectedIconColor = Provider.of<IconProvider>(context).selectedColor;

    return BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBarDesign(
          onPressed: () async {
            // ignore: unused_local_variable
            Uint8List? savedPhoto = await _saveDesign();
            {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchOnItem(),
                ),
              );
            }
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(AssetsData.BackGroundOfItem),
                Center(
                  child: GestureDetector(
                    child: Column(
                      children: [
                        RepaintBoundary(
                          key: _designKey,
                          child: Stack(
                            children: [
                              Image.asset(
                                images[_currentPageIndex],
                                height: 407,
                                width: 343,
                                fit: BoxFit.contain,
                                color: colorItemModel.colorOfItem,
                                colorBlendMode: BlendMode.modulate,
                              ),
                              if (selectedShape != null)
                                Positioned(
                                  height: 350,
                                  left: 100,
                                  right: 100,
                                  child: InteractiveViewer(
                                    transformationController: _controller,
                                    boundaryMargin: const EdgeInsets.symmetric(
                                        horizontal: 35, vertical: 100),
                                    onInteractionEnd: (details) {
                                      _saveStateForShape();
                                    },
                                    minScale: 0.1,
                                    maxScale: 1.6,
                                    child: Image.asset(
                                      selectedShape,
                                      color: selectedColor,
                                      colorBlendMode: BlendMode.modulate,
                                    ),
                                  ),
                                ),
                              if (selectedPhoto != null)
                                Positioned(
                                  height: 350,
                                  left: 100,
                                  right: 100,
                                  child: InteractiveViewer(
                                    boundaryMargin: const EdgeInsets.symmetric(
                                        horizontal: 35, vertical: 100),
                                    minScale: 0.1,
                                    maxScale: 1.6,
                                    onInteractionEnd: (details) {
                                      _saveStateForImage();
                                    },
                                    child: Image.memory(
                                      selectedPhoto.data,
                                      height: 200,
                                      width: 200,
                                    ),
                                  ),
                                ),
                              if (selectedIcons != null)
                                Positioned(
                                  height: 350,
                                  left: 100,
                                  right: 100,
                                  child: InteractiveViewer(
                                    transformationController: _controller,
                                    onInteractionEnd: (details) {
                                      _saveStateForImage();
                                    },
                                    boundaryMargin: const EdgeInsets.symmetric(
                                        horizontal: 35, vertical: 100),
                                    minScale: 0.1,
                                    maxScale: 1.6,
                                    child: Image.asset(
                                      selectedIcons,
                                      height: 200,
                                      width: 200,
                                      color: selectedIconColor,
                                      colorBlendMode: BlendMode.modulate,
                                    ),
                                  ),
                                ),
                              Consumer<AiPhotoProvider>(
                                builder: (context, aiPhotoProvider, _) {
                                  final selectedAiPhoto =
                                      aiPhotoProvider.selectedAiPhoto;
                                  if (selectedAiPhoto != null) {
                                    return Positioned(
                                      height: 350,
                                      left: 100,
                                      right: 100,
                                      child: Container(
                                        width: 200,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.memory(
                                            selectedAiPhoto.data,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              textModel.text.isNotEmpty
                                  ? Positioned(
                                      height: 450,
                                      right: 100,
                                      left: 100,
                                      child: Center(
                                        child: InteractiveViewer(
                                          // transformationController: _controller,
                                          boundaryMargin:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 30,
                                                  vertical: 100),
                                          minScale: 0.1,
                                          maxScale: 1.6,
                                          onInteractionEnd: (details) {
                                            // _saveStateForText();
                                          },
                                          child: Consumer<TextModel>(
                                            builder:
                                                (context, textModel, child) {
                                              return Text(
                                                textModel.text,
                                                style: GoogleFonts.getFont(
                                                  textModel.font,
                                                  fontSize: _fontSize,
                                                  color: textModel.color,
                                                ),
                                                textAlign: textModel.align,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 120,
                          child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: _pageController,
                            itemCount: images.length,
                            onPageChanged: (index) {
                              _handlePageChange();
                            },
                            itemBuilder: (context, index) {
                              double scaleFactor =
                                  index == _currentPageIndex ? 1.0 : 0.7;
                              return Transform.scale(
                                scale: scaleFactor,
                                child: Stack(children: [
                                  Image.asset(
                                    images[index],
                                    fit: BoxFit.contain,
                                    color: colorItemModel.colorOfItem,
                                    colorBlendMode: BlendMode.modulate,
                                  ),
                                  Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Container(
                                        height: 46,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: const GradientBoxBorder(
                                              width: 1,
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xffC9E9FF),
                                                  Color(0xffFFDACC),
                                                  Color(0xffFFE7BB),
                                                  Color(0xffE1FFB9),
                                                  Color(0xffFDA9FF),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Container(
                          height: 96,
                          width: width - 5,
                          decoration: BoxDecoration(
                            color: const Color(0xffFAFAFA).withOpacity(.6),
                            border: const Border(
                              top: BorderSide(width: 3, color: Colors.white),
                              right: BorderSide(width: 3, color: Colors.white),
                              left: BorderSide(width: 3, color: Colors.white),
                              bottom: BorderSide(width: 1, color: Colors.white),
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 56,
                                  width: 56,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.layers_outlined),
                                  ),
                                ),
                              ),
                              textModel.text.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 56,
                                            width: 56,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffD9D9D9)
                                                  .withOpacity(.5),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: TextButton(
                                              onPressed: () {},
                                              child: TextButton(
                                                  onPressed: () {},
                                                  child: Consumer<TextModel>(
                                                    builder: (context,
                                                        textModel, child) {
                                                      return Text(
                                                        textModel.text.isEmpty
                                                            ? 'Text'
                                                            : textModel.text,
                                                        style:
                                                            GoogleFonts.getFont(
                                                          textModel.font,
                                                          fontSize: textModel
                                                                  .text.isEmpty
                                                              ? 12.0
                                                              : 12.0,
                                                          color: textModel
                                                                  .text.isEmpty
                                                              ? const Color(
                                                                  0xff8E8E8E)
                                                              : textModel.color,
                                                        ),
                                                        textAlign:
                                                            textModel.align,
                                                      );
                                                    },
                                                  )),
                                            ),
                                          ),
                                          Positioned(
                                            top: -10,
                                            left: -10,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.close_outlined,
                                                color: Colors.red,
                                                size: 16,
                                              ), // replace with your desired icon
                                              onPressed: () {
                                                Provider.of<TextModel>(context,
                                                        listen: false)
                                                    .updateText('');
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              selectedShape != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 56,
                                            width: 56,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffD9D9D9)
                                                  .withOpacity(.5),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: TextButton(
                                              onPressed: () {},
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Image.network(
                                                  selectedShape,
                                                  color: selectedColor,
                                                  colorBlendMode:
                                                      BlendMode.modulate,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: -10,
                                            left: -10,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.close_outlined,
                                                size: 16,
                                                color: Colors.red,
                                              ), // replace with your desired icon
                                              onPressed: () {
                                                Provider.of<ShapeProvider>(
                                                        context,
                                                        listen: false)
                                                    .setSelectedShape(null);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              selectedPhoto != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 56,
                                            width: 56,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffD9D9D9)
                                                  .withOpacity(.5),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: TextButton(
                                              onPressed: () {},
                                              child: Image.memory(
                                                selectedPhoto.data,
                                                // height: 200,
                                                // width: 200,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: -10,
                                            left: -10,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.close_outlined,
                                                size: 16,
                                                color: Colors.red,
                                              ), // replace with your desired icon
                                              onPressed: () {
                                                Provider.of<PhotoProvider>(
                                                        context,
                                                        listen: false)
                                                    .setSelectedPhoto(null);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              selectedAiPhoto != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 56,
                                            width: 56,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffD9D9D9)
                                                  .withOpacity(.5),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: TextButton(
                                              onPressed: () {},
                                              child: Image.memory(
                                                selectedAiPhoto.data,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: -10,
                                            left: -10,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.close_outlined,
                                                size: 16,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                Provider.of<AiPhotoProvider>(
                                                        context,
                                                        listen: false)
                                                    .selectedAiPhoto = null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              selectedIcons != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 56,
                                            width: 56,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffD9D9D9)
                                                  .withOpacity(.5),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  selectedPhoto =
                                                      null; // This will remove the widget
                                                });
                                              },
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Image.network(
                                                  selectedIcons,
                                                  color: selectedIconColor,
                                                  colorBlendMode:
                                                      BlendMode.modulate,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: -10,
                                            left: -10,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.close_outlined,
                                                color: Colors.red,
                                                size: 16,
                                              ), // replace with your desired icon
                                              onPressed: () {
                                                Provider.of<IconProvider>(
                                                        context,
                                                        listen: false)
                                                    .setSelectedIcons(null);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        Container(
                          height: 91,
                          width: width - 5,
                          decoration: BoxDecoration(
                            color: const Color(0xffFAFAFA).withOpacity(.6),
                            border: const Border(
                              top: BorderSide(width: 1, color: Colors.white),
                              right: BorderSide(width: 3, color: Colors.white),
                              left: BorderSide(width: 3, color: Colors.white),
                              bottom: BorderSide(width: 3, color: Colors.white),
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(45),
                              bottomRight: Radius.circular(45),
                            ),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // Ai Generator
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          final height = MediaQuery.of(context)
                                              .size
                                              .height;
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                color: Colors.black.withOpacity(
                                                    0.5), // Change this to your desired color and opacity
                                                child: SizedBox(
                                                  height: height *
                                                      0.75, // This makes the bottom sheet take up 3/4 of the screen height
                                                  child: const AiGenerator(),
                                                ),
                                              );
                                            },
                                            isScrollControlled: true,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.auto_fix_high_outlined,
                                          color: Colors.purpleAccent,
                                        ),
                                        iconSize: 28,
                                      ),
                                      const Text(
                                        'Ai',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                                // Text
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          final height = MediaQuery.of(context)
                                              .size
                                              .height;
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                color: Colors.black.withOpacity(
                                                    0.5), // Change this to your desired color and opacity
                                                child: SizedBox(
                                                  height: height *
                                                      0.75, // This makes the bottom sheet take up 3/4 of the screen height
                                                  child: AddText(
                                                    initialText: text,
                                                    initialFont: font,
                                                    initialColor: color,
                                                    initialAlign: align,
                                                  ),
                                                ),
                                              );
                                            },
                                            isScrollControlled: true,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.text_fields_outlined,
                                        ),
                                        iconSize: 28,
                                      ),
                                      const Text(
                                        'Text',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                                // Color
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          final height = MediaQuery.of(context)
                                              .size
                                              .height;
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                color: Colors.black.withOpacity(
                                                    0.5), // Change this to your desired color and opacity
                                                child: SizedBox(
                                                  height: height *
                                                      0.35, // This makes the bottom sheet take up 3/4 of the screen height
                                                  child: const ChooseColor(),
                                                ),
                                              );
                                            },
                                            isScrollControlled: true,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.color_lens_outlined,
                                        ),
                                        iconSize: 28,
                                      ),
                                      const Text(
                                        'Color',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                                // Shapes
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          final height = MediaQuery.of(context)
                                              .size
                                              .height;
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                color: Colors.black.withOpacity(
                                                    0.5), // Change this to your desired color and opacity
                                                child: SizedBox(
                                                  height: height *
                                                      0.75, // This makes the bottom sheet take up 3/4 of the screen height
                                                  child: const AddShape(),
                                                ),
                                              );
                                            },
                                            isScrollControlled: true,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.circle_outlined,
                                        ),
                                        iconSize: 28,
                                      ),
                                      const Text(
                                        'Shapes',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                // Icons
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          final height = MediaQuery.of(context)
                                              .size
                                              .height;
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                color: Colors.black.withOpacity(
                                                    0.5), // Change this to your desired color and opacity
                                                child: SizedBox(
                                                  height: height *
                                                      0.75, // This makes the bottom sheet take up 3/4 of the screen height
                                                  child: const AddIcon(),
                                                ),
                                              );
                                            },
                                            isScrollControlled: true,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.insert_emoticon_outlined,
                                        ),
                                        iconSize: 28,
                                      ),
                                      const Text(
                                        'Icons',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                                // Photos
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          final height = MediaQuery.of(context)
                                              .size
                                              .height;
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                color: Colors.black.withOpacity(
                                                    0.5), // Change this to your desired color and opacity
                                                child: SizedBox(
                                                  height: height *
                                                      0.75, // This makes the bottom sheet take up 3/4 of the screen height
                                                  child:
                                                      const PhotoUploadScreen(),
                                                ),
                                              );
                                            },
                                            isScrollControlled: true,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.photo_outlined,
                                        ),
                                        iconSize: 28,
                                      ),
                                      const Text(
                                        'Photos',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
