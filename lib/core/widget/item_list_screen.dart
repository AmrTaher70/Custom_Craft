import 'package:custom_craft/core/widget/custom_cart.dart';
import 'package:flutter/material.dart';
import '../../helper/api.helper.dart'; // Ensure you have the correct path to your Api class file

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  List<dynamic> filteredItems = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    Api api = Api();
    var data = await api.get(
        url: 'https://api.example.com/items'); // Replace with your API URL

    setState(() {
      filteredItems = data
          .where((item) =>
              item['colour'] == '#8D8F8C' && item['name'].contains('Front'))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtered Items'),
      ),
      body: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          var item = filteredItems[index];
          return CustomCard(
            name: item['name'],
            imageUrl: item['url'],
          );
        },
      ),
    );
  }
}
