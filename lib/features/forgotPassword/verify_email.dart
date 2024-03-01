import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/forgotPassword/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24),
              child: Stack(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xffFAFAFA).withOpacity(.7),
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(
                        () => const ForgotPassword(),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: AssetsColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Verify Your Email',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Image.asset(
                    AssetsData.verify,
                    height: 187,
                    width: 187,
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 34),
                    child: Text(
                      'Please enter your 4 digit code that \n       sent to your email address ',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textWidthBasis: TextWidthBasis.longestLine,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff8E8E8E),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 67),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 56,
                              width: 48,
                              child: TextFormField(
                                onSaved: (pin1) {},
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(
                                        0xffFAFAFA,
                                      ),
                                      width: 2,
                                      // Change the color here
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(
                                          0xffFAFAFA), // Change the color here
                                    ),
                                  ),
                                ),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          ),
                          Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 56,
                              width: 48,
                              child: TextFormField(
                                onSaved: (pin2) {},
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(
                                        0xffFAFAFA,
                                      ),
                                      width: 2,
                                      // Change the color here
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(
                                          0xffFAFAFA), // Change the color here
                                    ),
                                  ),
                                ),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          ),
                          Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 56,
                              width: 48,
                              child: TextFormField(
                                onSaved: (pin3) {},
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(
                                        0xffFAFAFA,
                                      ),
                                      width: 2,
                                      // Change the color here
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(
                                          0xffFAFAFA), // Change the color here
                                    ),
                                  ),
                                ),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          ),
                          Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 56,
                              width: 48,
                              child: TextFormField(
                                onSaved: (pin4) {},
                                onChanged: (value) {
                                  if (value.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(
                                        0xffFAFAFA,
                                      ),
                                      width: 2,
                                      // Change the color here
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Color(
                                          0xffFAFAFA), // Change the color here
                                    ),
                                  ),
                                ),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: 359,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {},
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
                      child: const Text('Verify'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 160, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Didn’t receive a code?',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Resend',
                            style: TextStyle(
                              color: AssetsColors.primaryColor,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
