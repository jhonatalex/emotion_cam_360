// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:emotion_cam_360/ui/pages/login/signUp_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  late XFile image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text(
            "Profile",
            style: TextStyle(
              color: Colors.purple,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: getImage(),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button("Save image"),
                  IconButton(
                    onPressed: () async {
                      image = (await _picker.pickImage(
                          source: ImageSource.gallery))!;
                      setState(() {
                        image = image;
                      });
                    },
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.tealAccent,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
              ),
              const Text(
                "Salir",
                style: TextStyle(color: Colors.purple, fontSize: 25),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const SignUpPage()));
                  },
                  icon: const Center(
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.purple,
                      size: 40,
                    ),
                  )),
            ],
          ),
        )));
  }

  ImageProvider getImage() {
    if (image != null) {
      return FileImage(File(image.path));
    }
    return const AssetImage('assets/img/blank-profile.png');
  }

  Widget button(String name) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(colors: [
            Color(0xff8a32f1),
            Color(0xffad32f9),
          ]),
        ),
        child: Center(
            child: Text(
          name,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
