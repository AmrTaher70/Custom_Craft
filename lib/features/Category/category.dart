import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:custom_craft/core/widget/custom_app_bar.dart';
import 'package:custom_craft/core/widget/custom_cart.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/home/home_screen.dart';
import 'package:custom_craft/helper/api.helper.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<dynamic> items = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      Api api = Api();
      var data = await api.get(
          url:
              'http://customcrafttt.somee.com/api/Item/GetItems'); // Replace with your API URL
      setState(() {
        items = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
        print(errorMessage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
      child: Scaffold(
        appBar: CustomAppBar(
          text: const Text(
            'Choose a Blank',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff2E2E2E),
              size: 24,
            ),
            onPressed: () {
              Get.to(() => const HomeScreen(), transition: Transition.fadeIn);
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text('Error: $errorMessage'))
                : items.isEmpty
                    ? const Center(child: Text('No items found.'))
                    : Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: GridView.builder(
                          itemCount: items.length,
                          clipBehavior: Clip.none,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            mainAxisSpacing: 0,
                          ),
                          itemBuilder: (context, index) {
                            var item = items[index];
                            return CustomCard(
                              name: item['name'],
                              imageUrl: item['pictureUrl'],
                            );
                          },
                        ),
                      ),
      ),
    );
  }
}
