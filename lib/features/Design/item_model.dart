import 'package:custom_craft/constans/app_string/app_string.dart';
import 'package:custom_craft/core/utils/assets.dart';

class ItemModel {
  final String imgPath;
  final String smallImgPath;
  ItemModel({
    required this.imgPath,
    required this.smallImgPath,
  });
  static List<ItemModel> mainDesign = [
    ItemModel(
      imgPath: AssetsData.hoodie,
      smallImgPath: AssetsData.hoodie,
    ),
    ItemModel(
      imgPath: AssetsData.hoodie,
      smallImgPath: AssetsData.hoodie,
    ),
  ];
}
