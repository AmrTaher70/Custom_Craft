import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:custom_craft/constans/colors/colors.dart';
import 'package:custom_craft/core/utils/assets/assets.dart';
import 'package:custom_craft/core/utils/models/saved_photo_model.dart';
import 'package:custom_craft/core/widget/custom_app_bar.dart';
import 'package:custom_craft/core/widget/image_background.dart';
import 'package:custom_craft/features/Contact%20US/contact_us_screen.dart';
import 'package:custom_craft/features/CreateNewPassword/create_new_passwort_screen.dart';
import 'package:custom_craft/features/home/home_screen.dart';
import 'package:custom_craft/features/login/login_screen.dart';
import 'package:custom_craft/helper/api.helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Category/category.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

Api api = Api();

class _ProfileState extends State<Profile> {
  Uint8List? _webImage;
  File? _image;
  // String? _profilePictureUrl;
  Uint8List? cachedImageData;
  String? _userName;
  final Api api = Api(); // Instantiate your API helper

  @override
  void initState() {
    super.initState();
    loadCachedImageData();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ??
          'User'; // Default to 'User' if no username is found
    });
  }

  Future<void> loadCachedImageData() async {
    Uint8List? cachedImageData = await getProfilePictureData();
    if (cachedImageData != null) {
      setState(() {
        _webImage = cachedImageData;
      });
    } else {
      await _fetchProfilePicture(); // Fetch from API if no cached data
    }
  }

  Future<void> _fetchProfilePicture() async {
    const String url =
        'http://customcrafttt.somee.com/api/Account/ProfilePicture';

    try {
      final response = await api.get(url: url);

      if (response != null) {
        Uint8List imageData = base64Decode(response);
        setState(() {
          _webImage = imageData;
        });

        // Save the profile picture data in shared preferences
        await saveProfilePictureData(imageData);
      } else {
        // ignore: avoid_print
        print('Failed to fetch profile picture: No response');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching profile picture: $e');
    }
  }

  Future<void> saveProfilePictureData(Uint8List imageData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String base64String = base64Encode(imageData);
    await prefs.setString('profile_picture_data', base64String);
  }

  Future<Uint8List?> getProfilePictureData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64String = prefs.getString('profile_picture_data');
    if (base64String != null) {
      return base64Decode(base64String);
    } else {
      return null;
    }
  }

  void _onItemTapped(int index) {
    setState(() {});
    if (index == 0) {
      Get.to(() => const HomeScreen(), transition: Transition.fadeIn);
    } else if (index == 1) {
      Get.to(() => const Profile(), transition: Transition.fadeIn);
    }
  }

  Future<void> _getImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      if (kIsWeb) {
        Uint8List imageData = await pickedImage.readAsBytes();
        setState(() {
          _webImage = imageData;
        });
        String base64Image = base64Encode(imageData);
        await _uploadImage(base64Image);
      } else {
        File imageFile = File(pickedImage.path);
        setState(() {
          _image = imageFile;
        });
        Uint8List imageData = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageData);
        await _uploadImage(base64Image);
      }
    }
  }

  Future<void> _uploadImage(String base64Image) async {
    const String url =
        'http://customcrafttt.somee.com/api/Account/ProfilePicture';

    try {
      // Perform the POST request
      final response = await api.post(
        url: url,
        body: {'profilePictureUrl': base64Image},
      );

      // Check if response is plain text
      if (response != null && response is String && response == 'Saved') {
        // Assume the profile picture URL remains the same if it is saved successfully
        // Alternatively, you may want to refresh the profile picture URL from the server
        await _fetchProfilePicture();
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image: Unexpected response');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _logout(BuildContext context) async {
    const String url = 'http://customcrafttt.somee.com/api/Account/LogOut';

    try {
      final response = await api.post(url: url, body: {});

      // Print the full response for debugging
      print('Logout response: $response');

      if (response != null &&
          response is String &&
          response == 'LogOut Success!') {
        // Clear all shared preferences data
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        // Clear provider data
        // Assuming you use the provider package, this will depend on how you set up your providers.
        // This example assumes you have a provider called SavedImageModel that needs to be cleared.
        final savedImageModel =
            Provider.of<SavedImageModel>(context, listen: false);
        savedImageModel.clear();

        // Navigate to the login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );

        print('Logged out successfully');
      } else {
        print('Failed to log out: Unexpected response');
      }
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? imageProvider;
    if (kIsWeb && _webImage != null) {
      imageProvider = MemoryImage(_webImage!);
    } else if (_image != null) {
      imageProvider = FileImage(_image!);
    } else if (_webImage != null) {
      imageProvider = MemoryImage(_webImage!);
    } else {
      imageProvider = const AssetImage(
          AssetsData.imageProfile); // Replace with your asset image path
    }

    return BackGroundImage(
      child: Scaffold(
        appBar: CustomAppBar(
          text: const Text(
            'Profile',
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
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset(
                        AssetsData.navBarBackGround,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                            top: 18,
                            bottom: 14,
                          ),
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _onItemTapped(0);
                                },
                                icon: const Icon(Icons.home_outlined,
                                    color: Color(0xff8E8E8E)),
                                iconSize: 32,
                              ),
                              const Text(
                                'Home',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff8E8E8E),
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(top: 70, bottom: 16),
                          child: Center(
                              child: Text(
                            'Customize',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff8E8E8E),
                                fontWeight: FontWeight.w400),
                          )),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 24,
                            top: 18,
                            bottom: 14,
                          ),
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _onItemTapped(1);
                                },
                                icon: const Icon(Icons.person_2_outlined,
                                    color: AssetsColors.primaryColor),
                                iconSize: 32,
                              ),
                              const Text(
                                'Profile',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AssetsColors.primaryColor,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: imageProvider,
                            minRadius: 32,
                          ),
                          Positioned(
                            bottom: -5,
                            right: 0,
                            left: 30,
                            top: 30,
                            child: Container(
                              width:
                                  16, // Adjusted width to fit the icon properly
                              height:
                                  16, // Adjusted height to fit the icon properly
                              decoration: BoxDecoration(
                                color: const Color(0xffD9D9D9).withOpacity(.5),
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Center(
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.photo_camera_outlined,
                                    color: Colors.black,
                                    size: 24, // Adjust the icon size as needed
                                  ),
                                  onPressed: () => _getImage(context),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      if (_userName != null)
                        Text(
                          _userName!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const HomeScreen(),
                          transition: Transition.fadeIn);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.brush_outlined),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'My Designs',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right_outlined),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: 343,
                  color: const Color(0xffD8D8D8),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const CreateNewPasswordScreen(),
                          transition: Transition.fadeIn);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.key),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Change Password',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right_outlined),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: 343,
                  color: const Color(0xffD8D8D8),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const ContactUs(),
                          transition: Transition.fadeIn);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.headset_mic_outlined),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Help & Support',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right_outlined),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: 343,
                  color: const Color(0xffD8D8D8),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () async {
                      await _logout(context);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.logout_outlined),
                        SizedBox(width: 15),
                        Text(
                          'Sign out',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        // Spacer(),
                        // Icon(Icons.keyboard_arrow_right_outlined),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: 343,
                  color: const Color(0xffD8D8D8),
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => const CategoryScreen(),
                  transition: Transition.fadeIn);
            },
            backgroundColor: AssetsColors.primaryColor,
            elevation: 5,
            child: const Icon(Icons.add),
            // shape: BeveledRectangleBorder(),
          ),
        ),
      ),
    );
  }
}
