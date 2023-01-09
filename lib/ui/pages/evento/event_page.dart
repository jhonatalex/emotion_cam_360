import 'dart:io';

import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/event_controller.dart';
import '../../../servicies/auth_service.dart';
import '../home/home_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);
  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  Widget currentPage = const EventPage(
    key: null,
  );
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = HomePage("");
      });
    }
  }

  final picker = ImagePicker();

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _musicaController = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();

  final _evenController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    final imageObx = Obx(() {
      Widget image = Image.asset(
        'assets/img/blank-profile.png',
        fit: BoxFit.fill,
      );

      if (_evenController.pickedImageLogo.value != null) {
        image = Image.file(
          _evenController.pickedImageLogo.value!,
          fit: BoxFit.fill,
        );
      } else if (_evenController.evento.value?.overlay.isNotEmpty == true) {
        image = CachedNetworkImage(
          imageUrl: _evenController.evento.value!.overlay,
          progressIndicatorBuilder: (_, __, progress) =>
              CircularProgressIndicator(value: progress.progress),
          errorWidget: (_, __, ___) => const Icon(Icons.error),
          fit: BoxFit.fill,
        );
      }
      return image;
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xff141221),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Crear Evento",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              textItem("Introduzca Nombre del Evento",
                  _evenController.nameController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Seleccione Musica del Evento",
                  _evenController.musicController, false),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  const Text("Logo",
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                  //IMAGEN PIKER
                  const SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final pickedImage =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedImage != null) {
                        Get.find<EventController>()
                            .setImage(File(pickedImage.path));
                      }
                    },
                    child: Center(
                      child: ClipOval(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: imageObx,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              colorButton("Crear Evento"),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonItem(
      String imagePath, String buttonName, double size, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          elevation: 8,
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(
                width: 1,
                color: Colors.grey,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagePath,
                height: size,
                width: size,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                buttonName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(
      String name, TextEditingController controller, bool obsecureText) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: name,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color.fromARGB(255, 90, 0, 194),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget colorButton(String name) {
    return Obx(() {
      final isSaving = _evenController.isSaving.value;

      return Stack(children: [
        InkWell(
          onTap: () {
            try {
              isSaving ? null : _evenController.saveMyEvent();
              /*   // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => const HomePage()),
                  (route) => false); */
            } catch (e) {
              final snackbar = SnackBar(content: Text(e.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              setState(() {
                circular = false;
              });
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 90,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [
                Color(0xff604fef),
                Color.fromARGB(255, 153, 120, 230),
                Color(0xff604fef)
              ]),
            ),
            child: Center(
              child: circular
                  ? const CircularProgressIndicator()
                  : Text(name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
            ),
          ),
        ),
        if (isSaving) const CircularProgressIndicator()
      ]);
    });
  }
}
