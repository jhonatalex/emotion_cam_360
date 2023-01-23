import 'dart:async';
import 'dart:typed_data';
import 'package:chalkdart/chalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/entities/responseFirebase.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/pages/Upload_screen/upload_video_controller.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/button_play.dart';
import 'package:emotion_cam_360/ui/widgets/messenger_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../../widgets/background_gradient.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class UploadVideoPage extends StatefulWidget {
  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;
  String _txt = 'Cargando Videoa la nube....';
  late var urlDownload = '';
  UploadTask? uploadTask;
  double progress = 0.0;

  final _evenController = Get.find<EventController>();
  final controller = Get.find<UploadVideoController>();

  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception');
    return user;
  }

  Future<void> uploadVideoToFirebase(
      Uint8List? video, String rutaVideo, EventEntity currentEvent) async {
    //final eventFirebase = _evenController.eventoFirebase.value;

    final eventFirebase =
        await _evenController.getMyEventController(currentEvent.id);

    if (eventFirebase != null) {
      currentEvent = eventFirebase;
      try {
        var listaVideos = [];

        if (currentEvent.videos != null) {
          listaVideos = currentEvent.videos!;
        }

        final ref = firestore.doc('user_${currentUser.uid}/${currentEvent.id}');

        if (video != null) {
          final videoPath =
              '${currentUser.uid}/videos360/${path.basename(rutaVideo)}';

          final storageRef = storage.ref(videoPath);
          UploadTask uploadTask = storageRef.putData(
              video, SettableMetadata(contentType: 'video/mp4'));
          uploadTask.snapshotEvents.listen((event) {
            setState(() async {
              progress = ((event.bytesTransferred.toDouble() /
                          event.totalBytes.toDouble()) *
                      100)
                  .roundToDouble();

              if (progress == 100) {
                event.ref
                    .getDownloadURL()
                    .then((downloadUrl) => urlDownload = downloadUrl);
              }

              urlDownload = await storageRef.getDownloadURL();

              if (urlDownload != '') {
                listaVideos.add(urlDownload);
                print(chalk.brightGreen('URL FIREBASE  $urlDownload'));
                ref.set(currentEvent.toFirebaseMap(videos: listaVideos),
                    SetOptions(merge: true));
              }

              /*  if (urlDownload != '') {
                  Future.delayed(const Duration(seconds: 2), () {
                    Get.offNamed(RouteNames.finishQr, arguments: urlDownload);
                  });
                } */
            });
          });
        } else {
          ref.set(currentEvent.toFirebaseMap(), SetOptions(merge: true));
        }
      } on FirebaseException catch (e) {
        MessengerSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoPreferencesProvider>(context);
    final eventProvider = Provider.of<EventoActualPreferencesProvider>(context);

    /*  Future<void> saveVideo(Uint8List? videoByte, String videoPath,
        EventEntity eventoActual) async {
      await controller.saveMyVideoController(
          videoByte, videoPath, eventoActual);
    } */

    return Obx(() {
      final isloading = controller.loading.value;
      Responsefirebase? responsefirebase = controller.urlVideoObserver.value;
      var progresController = _evenController.progress;

      return Scaffold(
          backgroundColor: AppColors.vulcan,
          body: Stack(alignment: AlignmentDirectional.center, children: [
            BackgroundGradient(context),
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
                height: 200.0,
                width: 200.0,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 375),
                  child: _evenController.progress.value == 100
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.check_rounded,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Proceso Completado',
                              style: TextStyle(
                                fontFamily: "Verdana",
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        )
                      : LiquidCircularProgressIndicator(
                          value: _evenController.progress.value.toInt() / 100,
                          valueColor: const AlwaysStoppedAnimation(
                            AppColors.royalBlue,
                          ),
                          backgroundColor: Colors.white,
                          direction: Axis.vertical,
                          center: Text(
                            "${_evenController.progress.value}%",
                            style: const TextStyle(
                                fontFamily: "Verdana",
                                color: Colors.black87,
                                fontSize: 25.0),
                          ),
                        ),
                ),
              ),
              if (isloading)
                Text(
                  "Subiendo video a la nube...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: sclW(context) * 4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ElevatedButton(
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
              )
            ]),
          ]));
    });
  }
}
