import 'package:flutter/material.dart';

class DeletableWidget extends StatefulWidget {
  final List<Widget> children;

  const DeletableWidget({super.key, required this.children});

  @override
  _DeletableWidgetState createState() => _DeletableWidgetState();
}

class _DeletableWidgetState extends State<DeletableWidget> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return _visible
        ? Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 3,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ...widget.children,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red, // foreground
                  ),
                  onPressed: () {
                    setState(() {
                      _visible = false;
                    });
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
          )
        : Container();
  }
}
