import 'package:custom_craft/constans/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_craft/core/utils/models/selected_item.dart';
import 'package:custom_craft/features/Design/MainDesign/main_design.dart';

class CustomCard extends StatelessWidget {
  final String frontImage;
  final String backImage;
  final String itemName;

  const CustomCard({
    Key? key,
    required this.frontImage,
    required this.backImage,
    required this.itemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 153,
      width: 164,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.grey.withOpacity(.1),
            spreadRadius: 20,
            offset: const Offset(10, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: GestureDetector(
          onTap: () {
            var selectedPhotosProvider =
                Provider.of<ItemPhotosProvider>(context, listen: false);
            selectedPhotosProvider.setSelectedPhotos(frontImage, backImage);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainDesign(),
              ),
            );
          },
          child: Card(
            color: const Color(0xffADADAD).withOpacity(.1),
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      const Center(
                          child: CircularProgressIndicator(
                        color: AssetsColors.primaryColor,
                      )),
                      Positioned.fill(
                        child: Image.asset(
                          frontImage,
                          height: 118,
                          width: 98,
                          fit: BoxFit.fitHeight,
                          frameBuilder: (BuildContext context, Widget child,
                              int? frame, bool wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) {
                              return child;
                            }
                            return AnimatedOpacity(
                              opacity: frame == null ? 0 : 1,
                              duration: const Duration(seconds: 3),
                              curve: Curves.easeOut,
                              child: child,
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.27),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Container(
                    width: 175,
                    height: 33,
                    decoration: const BoxDecoration(
                      color: Color(0xffFAFAFA),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        itemName,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
