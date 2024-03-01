import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinEntry extends StatefulWidget {
  const PinEntry({super.key});

  @override
  State<PinEntry> createState() => _PinEntryState();
}

class _PinEntryState extends State<PinEntry> {
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 67),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 56,
                width: 48,
                child: TextFormField(
                  controller: controllers[index],
                  onChanged: (value) {
                    if (value.isEmpty) {
                      if (index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    } else if (value.length == 1) {
                      if (index < 3) {
                        FocusScope.of(context).nextFocus();
                      } else {
                        // Last digit entered, perform action
                      }
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xffFAFAFA),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xffFAFAFA),
                      ),
                    ),
                  ),
                  style: Theme.of(context).textTheme.headlineSmall,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
