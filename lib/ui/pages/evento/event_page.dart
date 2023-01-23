import 'dart:io';

import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/messenger_snackbar.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
        currentPage = HomePage();
      });
    }
  }

  final picker = ImagePicker();

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  bool circular = false;
  AuthClass authClass = AuthClass();

  final _evenController = Get.find<EventController>();

  late String textFile;

  var textFileImage = "";
  var textFileMp3 = "";

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _musicaController = TextEditingController();

    final eventProvider = Provider.of<EventoActualPreferencesProvider>(context);

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
                height: 20,
              ),
              textItem("Introduzca Nombre del Evento",
                  _evenController.nameController, false),
              const SizedBox(
                height: 15,
              ),
              filePikerCustom("Musica", 185, true),
              /* textItem("Seleccione Musica del Evento",
                  _evenController.musicController, false), */
              const SizedBox(
                height: 30,
              ),
              filePikerCustom("Logo", 170, false),
              const SizedBox(
                height: 25,
              ),
              colorButton("Crear Evento", true, eventProvider),
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

  Widget colorButton(
      String name, image, EventoActualPreferencesProvider eventProvider) {
    return Obx(() {
      final isSaving = _evenController.isSaving.value;
      final isloading = _evenController.isLoading.value;

      Future.delayed(const Duration(microseconds: 500), (() {
        if (_evenController.eventoFirebase.value != null) {
          eventProvider
              .saveEventPrefrerence(_evenController.eventoFirebase.value);

          //eventProvider.saveMusicPrefrerence(textFileMp3);
          //eventProvider.saveLogoPrefrerence(textFileImage);

          //lIMPIAR VISTA
          _evenController.eventoFirebase.value = null;
          // TRAE EL ULTIMO EVENTO CREADO
          _evenController.getEventBd();

          Get.offNamed(RouteNames.videoPage);
        }
      }));

      return Stack(alignment: AlignmentDirectional.center, children: [
        InkWell(
          onTap: () {
            if (_evenController.nameController.value.text != '') {
              try {
                _evenController.saveMyEvent();
              } catch (e) {
                final snackbar = SnackBar(content: Text(e.toString()));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
            } else {
              MessengerSnackBar(
                  context, "Por favor, debe ingresar un nombre al evento");
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 90,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [
                AppColors.royalBlue,
                AppColors.violet,
                AppColors.royalBlue,
              ]),
            ),
            child: Center(
              child: /* isloading
                  ? const CircularProgressIndicator()
                  :  */
                  Text(name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
            ),
          ),
        ),
        //if (isloading) const CircularProgressIndicator()
      ]);
    });
  }

  filePikerCustom(String texto, ancho, isMp3) {
    return Obx(() {
      if (_evenController.pickedImageLogo.value != null) {
        textFileImage = _evenController.pickedImageLogo.value!.path;
      }

      if (_evenController.pickedMp3File.value != null) {
        textFileMp3 = _evenController.pickedMp3File.value!.path;
      }

      return Row(
        children: [
          const SizedBox(
            width: 40,
          ),
          Text(texto,
              style: const TextStyle(fontSize: 17, color: Colors.white)),
          const SizedBox(
            width: 20,
          ),
          Row(children: [
            Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width - ancho,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: Color.fromARGB(255, 175, 180, 184), width: 1),
                ),
                child: Center(
                  child: Text(_setTextPath(textFileImage, textFileMp3, isMp3),
                      maxLines: 2, style: TextStyle(fontSize: 12)),
                )),
            IconButton(
              icon: const Icon(Icons.note_add_outlined),
              onPressed: () async {
                if (isMp3) {
                  //MUSICA
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.audio,
                  );
                  if (result != null) {
                    Get.find<EventController>()
                        .setMp3(File(result.files.single.path!));

                    //var file = File(result.files.single.path);
                  } else {
                    // User canceled the picker
                  }
                } else {
                  //IMAGEN
                  final pickedImage =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    Get.find<EventController>()
                        .setImage(File(pickedImage.path));
                  }
                }
              },
              style: IconButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 153, 120, 230),
                backgroundColor: Color(0xff604fef),
                hoverColor: Color(0xff604fef),
              ),
            ),
          ]),
        ],
      );
    });
  }

  String _setTextPath(String textFileImage, String textFileMp3, isMp3) {
    if (isMp3) {
      textFile = textFileMp3;
    } else {
      textFile = textFileImage;
    }

    return textFile.isEmpty
        ? textFile
        : textFile.substring(textFile.length - 45, textFile.length);
  }
}
