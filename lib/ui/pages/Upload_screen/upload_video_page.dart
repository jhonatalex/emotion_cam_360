import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:chalkdart/chalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/pages/Upload_screen/upload_video_controller.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:uuid/uuid.dart';

import '../../../entities/video.dart';
import '../../widgets/background_gradient.dart';

class UploadVideoPage extends StatelessWidget {
  String _txt = 'Cargando Video a la nube....';

  //FirebaseFirestore get firestore => FirebaseFirestore.instance;
  //FirebaseStorage get storage => FirebaseStorage.instance;
  //FirebaseAuth mAuth = FirebaseAuth.instance;

//LUEGO DE LA CARGA ENVIAR A LA PANTALLA DE QR CON LA URL DE DESCRAGA

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadVideoController>();

    var file = Get.arguments;
    var videoByte = file[0];
    var videoPath = file[1];

    print(chalk.brightGreen(file[0]));

    final isSaving = controller.isSaving.value;

    //_txt = " Su video ha sido cargado completamente.\n\n Redirigiendo...";

// GUARDAR EN BD FIRESTORE
/*
    Future<void> saveMyVideoProvider() async {
      print(chalk.brightGreen('LOG AQUI ENTRO PROVIDER'));

      try {
        final DateTime now = DateTime.now();
        final int millSeconds = now.millisecondsSinceEpoch;
        final String month = now.month.toString();
        final String date = now.day.toString();
        final String storageId = (millSeconds.toString() + "360");
        final String today = ('$month-$date');

        var ref = storage.ref().child("videos").child(today).child(storageId);

        var uploadTask = ref.putData(file[0]);

        Uri downloadUrl = (await uploadTask).downloadUrl;

        //final String url = downloadUrl.toString();

        //print(url);

      } catch (error) {
        print(error);
      }
    }
 */

    return Scaffold(
        backgroundColor: AppColors.vulcan,
        body: Stack(
          children: [
            BackgroundGradient(context),
            ListView(
              children: [
                Center(
                    child: SimpleCircularProgressBar(
                        progressColors: const [
                      Colors.cyan,
                      Color.fromARGB(255, 64, 251, 104)
                    ],
                        mergeMode: true,
                        onGetText: (double value) {
                          if (value == 100) {
                            if (!isSaving) {
                              controller.saveMyVideoController(
                                  videoByte, videoPath);

                              Get.offNamed(RouteNames.finishQr,
                                  arguments: controller.urlVideo.value);
                            }
                          }
                          return Text(
                            '${value.toInt()} %',
                            style: TextStyle(
                              fontSize: sclH(context) * 3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        })),
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  child: Text(
                    _txt,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: sclH(context) * 3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
