import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagaramclone/screens/UserMangeScreens/EmailSent.dart';
import 'package:instagaramclone/screens/UserMangeScreens/UserSignInScreen.dart';

class UserSingUpScreeen extends StatefulWidget {
  const UserSingUpScreeen({super.key});

  @override
  State<UserSingUpScreeen> createState() => _UserSingUpScreeenState();
}

class _UserSingUpScreeenState extends State<UserSingUpScreeen> {
  File? _image; // Variable to hold the selected image
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedfile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedfile != null) {
        setState(() {
          _image = File(pickedfile.path);
        });
      } else {
        if (kDebugMode) {
          print("Image Not Able To Select");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Image.asset(
                isDark ? 'assets/instagram.jpg' : 'assets/instagram.jpg',
                height: 150,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                color: isDark ? Colors.white : null,
                colorBlendMode: isDark ? BlendMode.srcIn : null,
              ),
              //stack for getitin the user profile page

              InkWell(
                // splashColor: Colors.grey,
                onTap: _pickImage, // Trigger image picker when avatar is tapped
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: _image != null
                      ? FileImage(_image!) // Show selected image if available
                      : const NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUspugOXub65sbxVHOEaD-JEKC8NNWgkWhlg&s",
                        ),
                ),
              ),

              const SizedBox(
                height: 35,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Your Username",
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  filled: true,
                  fillColor: isDark ? Colors.green : Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 14.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Your Name",
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 14.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter Your Email",
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 14.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: .0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const EmailSentScreen()));
                      },
                      splashColor: Colors.white.withOpacity(0.3),
                      highlightColor: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(9),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade400,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: const Text(
                            "Verify Email",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    " have an Account  ",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserSignInScreen()));
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
