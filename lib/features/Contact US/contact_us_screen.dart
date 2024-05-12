import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/core/widget/text_filed_data.dart';
import 'package:custom_craft/features/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

TextEditingController emailController = TextEditingController();
TextEditingController userNameController = TextEditingController();
TextEditingController messageController = TextEditingController();
TextEditingController messageSubjectController = TextEditingController();
String messageBody = messageController.text;
String messageSubject = messageSubjectController.text;

String recipientEmail = 'amrhafiz47@gmail.com';
final formKey = GlobalKey<FormState>();
bool isLoading = false;

class _ContactUsState extends State<ContactUs> {
  Future<void> sendEmail() async {
    final Uri emailLaunchUri =
        Uri(scheme: 'mailto', path: recipientEmail, queryParameters: {
      'subject': messageSubject,
      'body': messageBody // Add the message body parameter
    });

    try {
      if (await canLaunch(emailLaunchUri.toString())) {
        await launch(emailLaunchUri.toString());
      } else {
        throw 'Could not launch email';
      }
    } catch (e) {
      print('Error launching email: $e');
      // Handle error (e.g., show a snackbar or dialog to inform the user)
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    return BackGroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: formKey,
          child: Column(
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
                          () => const Profile(),
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
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(AssetsData.backGroundOfContactUs)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 55),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.headset_mic_outlined,
                            size: 40,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Contact Us',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Feel free to contact us any time. we will get back to you as soon as we can',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff8E8E8E),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFiledData(
                              labelText: 'User Name',
                              controller: userNameController,
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.person_2_outlined),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Username is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 16),
                          //   child: TextFiledData(
                          //     labelText: 'Email',
                          //     controller: emailController,
                          //     suffixIcon: IconButton(
                          //       onPressed: () {},
                          //       icon: const Icon(Icons.email_outlined),
                          //     ),
                          //     validator: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return 'Email is required';
                          //       } else if (!value.contains('@') ||
                          //           !value.contains('.')) {
                          //         return 'Invalid email format';
                          //       }
                          //       return null; // Return null if validation succeeds
                          //     },
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'subject is required';
                                }
                                return null;
                              },
                              controller: messageSubjectController,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'Type Subject here',
                                fillColor: const Color(0xffF3F3F3),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AssetsColors.primaryColor),
                                ),
                                filled: true,
                                // Adjust the contentPadding to fill the available space
                              ),
                              maxLines: null,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 124,
                            width: 360,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'message is required';
                                }
                                return null;
                              },
                              controller: messageController,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: 'Type your message here',
                                fillColor: const Color(0xffF3F3F3),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AssetsColors.primaryColor),
                                ),
                                filled: true,
                                // Adjust the contentPadding to fill the available space
                              ),
                              maxLines: null,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            width: 359,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  try {
                                    // Show loading indicator on the button
                                    setState(() {
                                      isLoading = true;
                                    });

                                    sendEmail();
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });

                                    debugPrint('Error during logIn: $e');

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('An error occurred: $e'),
                                      ),
                                    );
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AssetsColors
                                    .primaryColor, // Background color
                                // foregroundColor:
                                //     Colors.white, // Text color
                                // Button padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12), // Button border radius
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 18, // Text size
                                  fontWeight: FontWeight.w400, // Text weight
                                ),
                                elevation: 5, // Button elevation
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : const Text('Send'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
