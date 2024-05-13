import 'package:custom_craft/constans/app_string/app_string.dart';
import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:custom_craft/features/login/login_screen.dart';
import 'package:flutter/material.dart';

class ConfirmEmail extends StatefulWidget {
  const ConfirmEmail({super.key});

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            String email = 'example@example.com'; // Example email
            showSuccessDialog(context, email);
          },
          child: const Text('Show Success Dialog'),
        ),
      ),
    );
  }

  void showSuccessDialog(BuildContext context, String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _contentBox(context, email),
        );
      },
    );
  }

  Widget _contentBox(BuildContext context, String email) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            height: 314,
            width: 343,
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.only(top: 120.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xffFAFAFA).withOpacity(.6),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.white, width: 3)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Positioned(
                    left: 20.0,
                    right: 20.0,
                    child: Image.asset(
                        AssetsData.goConfirmEmail) // Change to your image path
                    ),
                const Text(
                  'Confirm Your Email Address',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'We sent a confirmation email to ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  '. Check your email and click on the confirmation link to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AssetsColors.primaryColor, // Background color
                      // foregroundColor:
                      //     Colors.white, // Text color
                      // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Button border radius
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18, // Text size
                        fontWeight: FontWeight.w400, // Text weight
                      ),
                      elevation: 5, // Button elevation
                    ),
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.close, size: 40),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
