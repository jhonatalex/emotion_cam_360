import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:chalkdart/chalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:uuid/uuid.dart';

import '../../../entities/video.dart';

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({Key? key}) : super(key: key);

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  String _txt = 'Cargando Video a la nube....';

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;
  FirebaseAuth mAuth = FirebaseAuth.instance;

  @override
  void initState() {
//TODO
// CARGAR EL VIDEO A FIRSETORE

    super.initState();
  }

//LUEGO DE LA CARGA ENVIAR A LA PANTALLA DE QR CON LA URL DE DESCRAGA

  @override
  Widget build(BuildContext context) {
    //final UploadVideoController controller = Get.find<UploadVideoController>();

    var file = Get.arguments;
    print(chalk.brightGreen(file[0]));

    void _finisnhUpload() {
      setState(() {
        _txt = " Su video ha sido cargado completamente.\n\n Redirigiendo...";
      });
    }

//GUARDAR EN BD FIRESTORE
    Future<void> saveMyVideoProvider() async {
      print(chalk.brightGreen('LOG AQUI ENTRO PROVIDER'));

      try {
        final DateTime now = DateTime.now();
        final int millSeconds = now.millisecondsSinceEpoch;
        final String month = now.month.toString();
        final String date = now.day.toString();
        final String storageId = (millSeconds.toString() + "FFF");
        final String today = ('$month-$date');

        var ref = storage.ref().child("video").child(today).child(storageId);

        var uploadTask = ref.putFile(file[1]);

        ///Uri downloadUrl = (await uploadTask).downloadUrl;

        //final String url = downloadUrl.toString();

        //print(url);

      } catch (error) {
        print(error);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.vulcan,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                tileMode: TileMode.clamp,
                stops: [
              0.0,
              1
            ],
                colors: [
              AppColors.violet,
              AppColors.royalBlue,
            ])),
        child: Column(
          children: [
            Center(
                child: Padding(
                    padding: EdgeInsets.all(sclW(context) * 25),
                    child: SimpleCircularProgressBar(
                        progressColors: const [
                          Colors.cyan,
                          Color.fromARGB(255, 64, 251, 104)
                        ],
                        mergeMode: true,
                        onGetText: (double value) {
                          if (value == 100) {}
                          return Text(
                            '${value.toInt()} %',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }))),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              child: Text(
                _txt,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            FloatingActionButton(onPressed: () => saveMyVideoProvider())
          ],
        ),
      ),
    );
  }
}
