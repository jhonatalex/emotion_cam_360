import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:emotion_cam_360/ui/pages/Upload_screen/upload_video_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
//import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';
import '../../widgets/background_gradient.dart';

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({super.key});

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;
  // String _txt = 'Cargando Videoa la nube....';
  late var urlDownload = '';
  UploadTask? uploadTask;
  double progresController = 0.0;

  final _evenController = Get.find<EventController>();
  final controller = Get.find<UploadVideoController>();
  String? shortenedUrl;
  @override
  void initState() {
    super.initState();
    _init();

    progresController = 0.0;
  }

  Future<void> _init() async {
    saveVideotoFirebase();
  } /* 

/data/user/0/com.marketglobal.emotionCam360/cache/REC760563348.mp4
/data/user/0/com.marketglobal.emotionCam360/cache/REC179645596.mp4 

*/

  void saveVideotoFirebase() {
    final videoProvider =
        Provider.of<VideoPreferencesProvider>(context, listen: false);
    final eventProvider =
        Provider.of<EventoActualPreferencesProvider>(context, listen: false);

    _evenController.uploadVideoToFirebase(videoProvider.videoPreferences,
        videoProvider.pathPreferences, eventProvider.eventPrefrerences);
  }

  //Finjir subida de porcentaje hacelo más fluido
  porcentUp() {
    if (_evenController.progressTemp.value < _evenController.progress.value) {
      Future.delayed(
          const Duration(
            milliseconds: 100,
          ), () {
        _evenController.progressTemp.value++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /*  Future<void> saveVideo(Uint8List? videoByte, String videoPath,
        EventEntity eventoActual) async {
      await controller.saveMyVideoController(
          videoByte, videoPath, eventoActual);
    } */

    return Obx(() {
      // final isSaving = _evenController.isSaving.value;

      progresController = _evenController.progressTemp.value;
      porcentUp();
      //************llamar al acortador */

      if (progresController == 100) {
        Future.delayed(const Duration(seconds: 2), () {
          clearView();
          progresController = 0.0;

          Get.offAllNamed(RouteNames.finishQr,
              arguments: shortenedUrl ?? _evenController.urlDownload.value);
        });
      }

      return Scaffold(
          backgroundColor: AppColors.vulcan,
          body: Stack(alignment: AlignmentDirectional.center, children: [
            AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: progresController / 100,
                child: BackgroundGradient(context)),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              /*        Container(
                height: 80,
                width: 80,
                child: const CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(255, 77, 188, 96),
                  color: AppColors.royalBlue,
                  strokeWidth: 15,
                ),
              ), */
              const SizedBox(height: 20),
              SizedBox(
                height: sclW(context) * 40,
                width: sclW(context) * 40,
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 375),
                    child: LiquidCircularProgressIndicator(
                      value: _evenController.progressTemp.value /
                          100, // Defaults to 0.5.
                      valueColor: AlwaysStoppedAnimation(AppColors
                          .royalBlue), // Defaults to the current Theme's accentColor.
                      backgroundColor: Colors
                          .white, // Defaults to the current Theme's backgroundColor.
                      borderColor: AppColors.royalBlue,
                      borderWidth: 1.0,
                      direction: Axis
                          .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                      center: Text(
                        "${progresController.toStringAsFixed(0)} %",
                        style:
                            const TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    )
                    /* Text(
                            "${_evenController.progress.value} %",
                            style: const TextStyle(fontSize: 40),
                          ) */
                    /* LiquidCircularProgressIndicator(
                          value: _evenController.progress.value / 100,
                          valueColor: const AlwaysStoppedAnimation(
                            AppColors.royalBlue,
                          ),
                          backgroundColor: Colors.white,
                          direction: Axis.vertical,
                          center: Text(
                            "${_evenController.progress.value.toInt()}%",
                            style: const TextStyle(
                                fontFamily: "Verdana",
                                color: Colors.black87,
                                fontSize: 25.0),
                          ),
                        ), */
                    ),
              ),
              const SizedBox(height: 30),
              Text(
                "Subiendo video a la nube...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sclW(context) * 4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              /* ElevatedButton(
                child: Text("SUBIR"),
                onPressed: () {
                  /*     uploadVideoToFirebase(
                      videoProvider.videoPreferences,
                      videoProvider.pathPreferences,
                      eventProvider.eventPrefrerences); */

                  _evenController.uploadVideoToFirebase(
                      videoProvider.videoPreferences,
                      videoProvider.pathPreferences,
                      eventProvider.eventPrefrerences);
                },
              ) */
            ]),
          ]));
    });
  }

  void clearView() {}
}
