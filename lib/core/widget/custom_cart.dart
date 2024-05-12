import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:custom_craft/features/Design/main_design.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
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
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainDesign()),
            );
          },
          child: Card(
            color: const Color(0xffADADAD).withOpacity(.1),
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Positioned(
                  top: 20,
                  bottom: 55,
                  left: 50,
                  child: Image.asset(
                    AssetsData.hoodie,
                    height: 118,
                    width: 98,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(height: 5.27),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Container(
                    width: 175,
                    height: 35,
                    decoration: const BoxDecoration(
                        color: Color(0xffFAFAFA),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16))),
                    child: const Center(
                      child: Text(
                        'Hoodie',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
