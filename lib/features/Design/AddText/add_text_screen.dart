import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/widget/custom_app_bar_for_tools.dart';
import 'package:flutter/material.dart';

class AddText extends StatefulWidget {
  const AddText({super.key});

  @override
  State<AddText> createState() => _AddTextState();
}

class _AddTextState extends State<AddText> {
  late TextEditingController _textController;
  final Color _selectedColor = Colors.black;
  double _fontSize = 24.0;
  final FontWeight _fontWeight = FontWeight.normal;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA).withOpacity(.5),
      appBar: const CustomAppBarForTools(
        text: Text(
          'Text',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 343,
              height: 356,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Enter text here',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Font Size: $_fontSize'),
                    Slider(
                      value: _fontSize,
                      min: 10,
                      max: 50,
                      divisions: 4,
                      onChanged: (value) {
                        setState(() {
                          _fontSize = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
