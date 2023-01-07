import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/pages/Upload_screen/upload_video_controller.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../../widgets/background_gradient.dart';

class UploadVideoPage extends StatelessWidget {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;
  String _txt = 'Cargando Videoa la nube....';
  late final String urlDownload;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadVideoController>();
    final isSaving = controller.isSaving.value;
    var file = Get.arguments;
    var videoByte = file[0];
    var videoPath = file[1];
    var eventoActual = file[2];

    Future<void> saveVideo(Uint8List? videoByte, String videoPath,
        EventEntity eventoActual) async {
      await controller.saveMyVideoController(
          videoByte, videoPath, eventoActual);
    }

    if (!isSaving) {
      try {
        saveVideo(videoByte, videoPath, eventoActual);
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }

    return Scaffold(
        backgroundColor: AppColors.vulcan,
        body: Stack(
          children: [
            BackgroundGradient(context),
            ListView(
              children: [
                Center(
                    child: Padding(
                        padding: EdgeInsets.all(sclW(context) * 25),
                        child: Obx(() {
                          final isloading = controller.loading.value;
                          final urlQR = controller.urlVideoObserver.value;

                          return Center(
                            child: Column(children: [
                              SizedBox(
                                  height: 300,
                                  child: SimpleCircularProgressBar(
                                      progressColors: const [
                                        Colors.cyan,
                                        Color.fromARGB(255, 64, 251, 104)
                                      ],
                                      mergeMode: true,
                                      onGetText: (progressValue) {
                                        if (progressValue == 100) {
                                          if (urlQR != '') {
                                            Get.offNamed(RouteNames.finishQr,
                                                arguments: controller
                                                    .urlVideoObserver.value);
                                          }
                                        }
                                        return Text(
                                          '${progressValue.toInt()} %',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        );
                                      })),
                              if (isloading)
                                Text(
                                  "Cargando Video..",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: sclH(context) * 3,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                            ]),
                          );
                        }))),
              ],
            ),
          ],
        ));
  }
}
