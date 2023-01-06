import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:chalkdart/chalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/controllers/auth_controller.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/pages/Upload_screen/upload_video_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:uuid/uuid.dart';

import '../../../data/firebase_provider-db.dart';
import '../../../entities/video.dart';
import '../../routes/route_names.dart';
import '../../widgets/background_gradient.dart';
import 'package:path/path.dart' as path;

class UploadVideoPage extends StatefulWidget {
  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  //final provider = FirebaseProvider();
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;

  String _txt = 'Cargando Video a la nube....';

  UploadTask? uploadTask;

  late final String urlDownload;

  @override
  void initState() {
    super.initState();
    //getMyEventClass();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UploadVideoController>();
    final provider = Get.find<FirebaseProvider>();

    var file = Get.arguments;
    var videoByte = file[0];
    var videoPath = file[1];
    var eventoActual = file[2];

    print(chalk.redBright('UPLOAD $videoByte '));
    final isSaving = controller.isSaving.value;
    //_txt = " Su video ha sido cargado completamente.\n\n Redirigiendo...";

    /*  Future<void> _saveVideo(Uint8List? videoByte, String videoPath) async {
      String url = await controller.saveMyVideoController(videoByte, videoPath);

      var url2 = controller.urlVideoObserver.value;

    } */

    Future saveVideoFirebase(Uint8List? video, rutaVideo, currentEvent) async {
      final DateTime now = DateTime.now();
      final int millSeconds = now.millisecondsSinceEpoch;
      final String month = now.month.toString();
      final String date = now.day.toString();
      final String storageId = ("VID_360_" + millSeconds.toString());
      final String today = ('$date - $month');

      //var listaVideos = [];

      var listaVideos = currentEvent.videos;

      print(chalk.brightGreen(currentEvent.videos));

      final ref = firestore.doc(
          'user_${Get.find<AuthController>().authUser.value!.uid}/Barinas');

      //EventEntity currentEvent =
      //const EventEntity('Barinas', 'barinas', 'music', overlay: "overlay");

      if (video != null) {
        final videoPath =
            '${Get.find<AuthController>().authUser.value!.uid}/videos360/${path.basename(rutaVideo)}';

        final storageRef = storage.ref(videoPath);

        setState(() {
          uploadTask = storageRef.putData(
              video, SettableMetadata(contentType: 'video/mp4'));
        });

        final snapshot =
            await uploadTask!.whenComplete(() {}).catchError((onError) {
          print(onError);
        });

        urlDownload = await snapshot.ref.getDownloadURL();
        print(chalk.brightGreen('LOG AQUI $urlDownload'));

        listaVideos.add(urlDownload);

        await ref.set(currentEvent.toFirebaseMap(videos: listaVideos),
            SetOptions(merge: true));
      } else {
        await ref.set(currentEvent.toFirebaseMap(), SetOptions(merge: true));
      }

      setState(() {
        uploadTask = null;
        if (urlDownload != '') {
          _txt = " Su video ha sido cargado completamente.\n\n Redirigiendo...";
          Get.offNamed(RouteNames.finishQr, arguments: urlDownload);
        }
      });

//-------------------------------------------
      /* var ref = storage.ref().child("videos").child(today).child(storageId);

      setState(() {
        uploadTask =
            ref.putData(video!, SettableMetadata(contentType: 'video/mp4'));
      });

      final snapshot =
          await uploadTask!.whenComplete(() {}).catchError((onError) {
        print(onError);
      });

      urlDownload = await snapshot.ref.getDownloadURL();

      print(chalk.brightGreen('LOG AQUI $urlDownload'));

      setState(() {
        uploadTask = null;

        if (urlDownload != '') {
          _txt = " Su video ha sido cargado completamente.\n\n Redirigiendo...";
          Get.offNamed(RouteNames.finishQr, arguments: urlDownload);
        }
      }); */
    }

    if (!isSaving) {
      try {
        saveVideoFirebase(videoByte, videoPath, eventoActual);
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }

    Widget buildProgress() => StreamBuilder<TaskSnapshot>(
          stream: uploadTask?.snapshotEvents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              double progressValue = data.bytesTransferred / data.totalBytes;

              return SizedBox(
                  height: 200,
                  child: SimpleCircularProgressBar(
                      progressColors: const [
                        Colors.cyan,
                        Color.fromARGB(255, 64, 251, 104)
                      ],
                      mergeMode: true,
                      onGetText: (Value) {
                        return Text(
                          '${progressValue.toInt()} %',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }));
            } else {
              return const SizedBox(height: 10);
            }
          },
        );

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
                        child: buildProgress())),
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
                FloatingActionButton(
                    child: Icon(Icons.upload_file), onPressed: () {})
              ],
            ),
          ],
        ));
  }
}
