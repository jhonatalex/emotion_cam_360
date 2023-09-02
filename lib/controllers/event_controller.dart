import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:chalkdart/chalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/data/firebase_provider-db.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/repositories/implementations/event_repositoryImple.dart';
import 'package:emotion_cam_360/ui/pages/video_processing/video_util.dart';
import 'package:ffmpeg_kit_flutter_min_gpl/ffmpeg_kit_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/user.dart';
import 'package:path/path.dart' as path;

class EventController extends GetxController {
  final _eventRepository = Get.find<EventRepositoryImple>();

  final provider = FirebaseProvider();
  final nameController = TextEditingController();
  final musicController = TextEditingController();
  final logoController = TextEditingController().obs;

  Rx<File?> pickedImageLogo = Rx(
      File("/data/user/0/com.marketglobal.emotionCam360/cache/watermark.png"));
  Rx<File?> pickedMp3File = Rx(
      File("/data/user/0/com.marketglobal.emotionCam360/cache/hallman-ed.mp3"));

  Rx<bool> isLoading = Rx(false);
  Rx<bool> isSaving = Rx(false);
  Rx<EventEntity?> eventoFirebase = Rx(null);
  Rx<EventEntity?> eventoBd = Rx(null);
  Rx<MyUser?> user = Rx(null);

  var eventos = [].obs;
  var suscripciones = [].obs;

  Rx<EventEntity?> eventoSelected = Rx(null);

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseStorage get storage => FirebaseStorage.instance;
  late var urlDownload = ''.obs;
  UploadTask? uploadTask;
  RxDouble progress = 0.0.obs;

  User get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated exception');
    return user;
  }

  @override
  void onInit() {
    //TRER LISTA DE EVENTOS
    getEventBd();
    getAllMyEventController();
    getAllSuscripcionesController();
    super.onInit();

    //prepara las assets y los pasa al cache,
    // esto para la musica y el logo default
    FFmpegKitConfig.init().then((_) {
      VideoUtil.prepareAssets();
    });
  }

  void setImage(File? imageFileLogo) async {
    pickedImageLogo.value = imageFileLogo;
  }

  void setMp3(File? mp3File) {
    pickedMp3File.value = mp3File;
  }

  Future<void> saveMyEvent() async {
    isSaving.value = true;
    isLoading.value = true;
    final DateTime now = DateTime.now();

    final String month = now.month.toString();
    final String day = now.day.toString();
    final String year = now.year.toString();

    final String today = ('$day-$month-$year');
    final uid = "${nameController.text.trim()}_fecha_$today";
    final name = nameController.text;

    final newEvent = EventEntity(uid, name, pickedMp3File.value!.path,
        overlay: pickedImageLogo.value!.path);
    //evento.value = newEvent;
    //TO REPOSITORY
    await _eventRepository.saveMyEvento(
        newEvent, pickedImageLogo.value, pickedMp3File.value);

    eventoFirebase.value = newEvent;

    isSaving.value = false;
    isLoading.value = false;
  }

  Future<EventEntity?> getMyEventController(String idEvent) async {
    isLoading.value = true;
    //TO REPOSITORY
    final newEvent = await _eventRepository.getMyEventFirebase(idEvent);
    eventoFirebase.value = newEvent;
    isLoading.value = false;
    return newEvent;
  }

  Future<void> getAllMyEventController() async {
    //TO REPOSITORY
    final listEvent = await _eventRepository.getAllMyEventFirebase();

    //CONVERTIR RESPUESTA EN ENTITIES
    List<EventEntity?> listEventEntity = [];

    for (var doc in listEvent) {
      EventEntity eventNew = EventEntity(doc["id"], doc["name"], doc["music"],
          overlay: doc["overlay"], videos: doc["videos"]);

      listEventEntity.add(eventNew);
    }
    eventos.value = listEventEntity;
  }

  Future<void> getEventBd() async {
    if (isLoading.isTrue) return;
    isLoading.value = true;
    //final newEvent = await _eventRepository.getNewEvent();
    //eventos.insert(0, newEvent);
    eventoBd.value = await _eventRepository.getLastEvent();
    isLoading.value = false;
  }

  Future<void> deleteEvent(EventEntity toDelete) async {
    // ignore: invalid_use_of_protected_member
    eventos.value.remove(toDelete);
    _eventRepository.deleteEvent(toDelete);
  }

  Future<void> uploadVideoToFirebase(
      Uint8List? video, String rutaVideo, EventEntity currentEvent) async {
    isSaving.value = true;

    final DateTime now = DateTime.now();
    final int millSeconds = now.millisecondsSinceEpoch;
    final String month = now.month.toString();
    final String day = now.day.toString();
    final String year = now.year.toString();
    final String today = ('$day-$month-$year');
    final String storageId = ("VID_360_$millSeconds$day");

    final ref = firestore.doc('user_${currentUser.uid}/${currentEvent.id}');

    if (video != null) {
      final videoPath =
          '${currentUser.uid}/videos360/${currentEvent.id}/$today/${storageId + day + path.basename(rutaVideo)}';

      final storageRef = storage.ref(videoPath);
      UploadTask uploadTask =
          storageRef.putData(video, SettableMetadata(contentType: 'video/mp4'));
      uploadTask.snapshotEvents.listen((event) {
        progress.value =
            ((event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) *
                    100)
                .roundToDouble();

        if (progress.value == 100) {
          event.ref.getDownloadURL().then((downloadUrl) {
            urlDownload.value = downloadUrl;

            ref.update({
              "videos": FieldValue.arrayUnion([urlDownload.value]),
            });
          });
        }
      });

      //urlDownload.value = await storageRef.getDownloadURL();

      //if (urlDownload.isNotEmpty) {
      // print(chalk.brightGreen('URL FIREBASE  ${urlDownload.value}'));

      /*   ref.update({
          "videos": FieldValue.arrayUnion([urlDownload.value]),
        }); */

      // ref.set(eventFirebase.toFirebaseMap(videos: listaVideos),
      // SetOptions(merge: true));

      // }
    } else {
      ref.set(currentEvent.toFirebaseMap(), SetOptions(merge: true));
    }
    //}
  }

  // OBTENER TIPOS DE SUSCRIPCIONES//
  Future<void> getAllSuscripcionesController() async {
    //TO REPOSITORY
    final listSuscripciones =
        await _eventRepository.getAllSuscripcionesFirebase();

    suscripciones.value = listSuscripciones;
      print(chalk.white.bold(suscripciones.value));
  }
}
