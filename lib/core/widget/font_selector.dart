import 'package:flutter/material.dart';

class FontSelector extends StatefulWidget {
  final Function(String) onFontChanged;

  const FontSelector({required this.onFontChanged, super.key});

  @override
  _FontSelectorState createState() => _FontSelectorState();
}

class _FontSelectorState extends State<FontSelector> {
  String dropdownValue = 'Roboto';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 341,
      decoration: const BoxDecoration(
        color: Color(0xffD3D3D3),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Center(
        child: DropdownButton<String>(
          value: dropdownValue,
          alignment: Alignment.center,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 0,
          style: const TextStyle(color: Colors.black),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
            widget.onFontChanged(newValue!);
          },
          items: <String>[
            'Roboto',
            'Open Sans',
            'Lato',
            'Raleway',
            'Montserrat'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 90.0, left: 100), // Add this line
                child: Text(
                  value,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
