import 'dart:io';
import 'dart:ui';

import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/background_gradient.dart';
import 'package:emotion_cam_360/ui/widgets/messenger_snackbar.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../controllers/event_controller.dart';
import '../../../servicies/auth_service.dart';
import '../home/home_page.dart';

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
  int nombreImg = 13;
  String imgSelected = "assets/img/logo-emotion.png";

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  bool circular = false;
  AuthClass authClass = AuthClass();

  final _evenController = Get.find<EventController>();

  late String textFile;

  var textFileImage = "";
  var textFileMp3 = "";

  static Future<Directory> get tempDirectory async {
    return await getTemporaryDirectory();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _musicaController = TextEditingController();

    final eventProvider = Provider.of<EventoActualPreferencesProvider>(context);

    print(chalk.yellow.bold(textFileImage));
    print(chalk.yellow.bold(textFileMp3));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Crear Evento",
          style: TextStyle(
            fontSize: sclH(context) * 3,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          width: sclW(context) * 100,
          height: sclH(context) * 100,
          color: const Color(0xff141221),
          child: Stack(
            children: [
              BackgroundGradient(context),
              Center(
                child: ListView(
                  children: [
                    Container(
                      height: sclW(context) * 100,
                      child: Opacity(
                        opacity: 0.5,
                        child: ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                            child: imgSelected.contains("assets")
                                ? Image.asset(
                                    imgSelected,
                                  )
                                : Image.file(
                                    File(imgSelected),
                                  )),
                      ),
                    ),
                    SizedBox(
                      height: sclH(context) * 45,
                    )
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: sclH(context) * 30,
                      child: imgSelected.contains("assets")
                          ? Image.asset(
                              imgSelected,
                            )
                          : Image.file(
                              File(imgSelected),
                            ),
                    ),
                    SizedBox(
                      height: sclH(context) * 45,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: sclH(context) * 50,
                  left: sclW(context) * 5,
                  right: sclW(context) * 5,
                  bottom: sclH(context) * 5,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: sclW(context) * 5, vertical: sclW(context) * 5),
                decoration: BoxDecoration(
                  color: AppColors.vulcan,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListView(
                  padding: EdgeInsets.only(top: 5),
                  children: [
                    textItem(context, "Introduzca Nombre del Evento",
                        _evenController.nameController, false),
                    const SizedBox(
                      height: 30,
                    ),
                    filePikerCustom(context, "Musica", 185, true),
                    /* textItem("Seleccione Musica del Evento",
                        _evenController.musicController, false), */
                    const SizedBox(
                      height: 30,
                    ),
                    filePikerCustom(context, "Logo", 170, false),
                    const SizedBox(
                      height: 30,
                    ),
                    colorButton(context, "Crear Evento", true, eventProvider),
                    const SizedBox(
                      height: 15,
                    ),
                    /*   ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilePickerDemo()));
                        },
                        child: Text("Ejemplo")) */
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonItem(BuildContext context, String imagePath, String buttonName,
      double size, Function() onTap) {
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

  Widget textItem(BuildContext context, String name,
      TextEditingController controller, bool obsecureText) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        style: TextStyle(
          fontSize: sclH(context) * 2.5,
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

  Widget colorButton(BuildContext context, String name, image,
      EventoActualPreferencesProvider eventProvider) {
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

  filePikerCustom(BuildContext context, String texto, ancho, isMp3) {
    return Obx(() {
      if (_evenController.pickedImageLogo.value != null) {
        textFileImage = _evenController.pickedImageLogo.value!.path;
      }

      if (_evenController.pickedMp3File.value != null) {
        textFileMp3 = _evenController.pickedMp3File.value!.path;
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(texto,
              style:
                  TextStyle(fontSize: sclH(context) * 2, color: Colors.white)),
          Row(children: [
            Container(
                padding: const EdgeInsets.all(10.0),
                width: sclW(context) * 55,
                height: sclW(context) * 13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: const Color.fromARGB(255, 175, 180, 184),
                      width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_setTextPath(textFileImage, textFileMp3, isMp3),
                        maxLines: 2,
                        style: TextStyle(fontSize: sclH(context) * 2)),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                child: IconButton(
                  icon: const Icon(Icons.note_add_outlined),
                  onPressed: () async {
                    if (isMp3) {
                      //MUSICA
                      //
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['mp3'],
                        withData: true,
                      );
                      final String musicName = result?.files.single.name ?? "0";
                      final String path = result?.files.single.path! ?? "0";
                      final dataBytes = result?.files.single.bytes;
                      print(chalk.white.bold(musicName));
                      print(chalk.white.bold(path));
                      //print(chalk.white.bold(dataBytes));

                      final List<int> byteList = dataBytes!.buffer.asUint8List(
                          dataBytes.offsetInBytes, dataBytes.lengthInBytes);

                      final String fullTemporaryPath = join(
                          (await tempDirectory).path,
                          musicName.replaceAll(" ", "-"));
                      print(chalk.yellow.bold(fullTemporaryPath));

                      Future<File> fileFuture = File(fullTemporaryPath)
                          .writeAsBytes(byteList,
                              mode: FileMode.writeOnly, flush: true);

                      /*  if (path.contains(' ')) {
                        // ignore: use_build_context_synchronously
                        MessengerSnackBar(context,
                            "El nombre del audio no debe contener espacios, por favor corrígelo e intenta de nuevo");
                      } else */
                      if (result != null) {
                        Get.find<EventController>()
                            .setMp3(File(fullTemporaryPath));
                      } else {
                        // User canceled the picker
                      }

                      /*    MediaPicker.picker(
                        context,
                        type: RequestType.audio,
                        //isReview: isReview,
                        singleCallback: (AssetEntity asset) {
                          print(chalk
                              .brightGreen('PATHC AUDIO ${asset.relativePath!}'));
              
                          Get.find<EventController>()
                              .setMp3(File(asset.relativePath!));
                          //return single item if  isMulti false
                        },
                      ); */
                    } else {
                      //IMAGEN
                      final pickedImage =
                          await picker.pickImage(source: ImageSource.gallery);
                      nombreImg = pickedImage!.name.length;
                      if (pickedImage != null) {
                        Get.find<EventController>()
                            .setImage(File(pickedImage.path));
                        setState(() {
                          imgSelected = pickedImage.path;
                        });
                      }
                    }
                  },
                  style: IconButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 153, 120, 230),
                    backgroundColor: const Color(0xff604fef),
                    hoverColor: const Color(0xff604fef),
                  ),
                ),
              ),
            ),
          ]),
        ],
      );
    });
  }

  String _setTextPath(String textFileImage, String textFileMp3, isMp3) {
    if (isMp3) {
      textFile = textFileMp3.substring(50, textFileMp3.length);
    } else {
      nombreImg > 45 ? nombreImg = 45 : nombreImg;
      textFile = textFileImage.substring(
          textFileImage.length - nombreImg, textFileImage.length);
      print(chalk.white.bold(textFileImage.length));
    }

    return textFile;
  }
}
