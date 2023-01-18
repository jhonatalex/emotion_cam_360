import 'dart:async';
import 'dart:io';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/data/firebase_provider-db.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/repositories/implementations/event_repositoryImple.dart';
import 'package:emotion_cam_360/ui/pages/video_processing/video_util.dart';
import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/user.dart';
import '../repositories/abstractas/event_repository.dart';
import 'auth_controller.dart';

class EventController extends GetxController {
  final _eventRepository = Get.find<EventRepositoryImple>();

  final provider = FirebaseProvider();
  final nameController = TextEditingController();
  final musicController = TextEditingController();
  final logoController = TextEditingController().obs;

  Rx<File?> pickedImageLogo =
      Rx(File("/data/user/0/com.example.emotion_cam_360/cache/watermark.png"));
  Rx<File?> pickedMp3File =
      Rx(File("/data/user/0/com.example.emotion_cam_360/cache/hallman-ed.mp3"));

  Rx<bool> isLoading = Rx(false);
  Rx<bool> isSaving = Rx(false);
  Rx<EventEntity?> evento = Rx(null);
  Rx<EventEntity?> eventoBd = Rx(null);
  Rx<MyUser?> user = Rx(null);

  final eventos = [].obs;

  Rx<EventEntity?> eventoSelected = Rx(null);

  @override
  void onInit() {
    //TRER LISTA DE EVENTOS
    getEventBd();
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
    final musica = musicController.text;

    final newEvent = EventEntity(uid, name, pickedMp3File.value!.path,
        overlay: pickedImageLogo.value!.path);
    //evento.value = newEvent;
    //TO REPOSITORY
    await _eventRepository.saveMyEvento(
        newEvent, pickedImageLogo.value, pickedMp3File.value);

    evento.value = newEvent;

    isSaving.value = false;
    isLoading.value = false;
  }

  Future<void> getMyEventController(String idEvent) async {
    isLoading.value = true;
    //TO REPOSITORY
    print(chalk.brightGreen('entro eventController event ${idEvent}'));
    final newEvent = await _eventRepository.getMyEventFirebase(idEvent);
    evento.value = newEvent;
    print(chalk.redBright(newEvent));
    isLoading.value = false;
  }

  //BASE DATOS
  Future<void> loadInitialData() async {
    isLoading.value = true;

    isLoading.value = false;
  }

  Future<void> getEventBd() async {
    if (isLoading.isTrue) return;
    isLoading.value = true;
    //final newEvent = await _eventRepository.getNewEvent();
    //eventos.insert(0, newEvent);
    eventoBd.value = await _eventRepository.getLastEvent();
    print(chalk.red('EVENTO DE BASE DE DATOS ${eventoBd.value}'));
    isLoading.value = false;
  }

  Future<void> deleteEvent(EventEntity toDelete) async {
    eventos.remove(toDelete);
    _eventRepository.deleteEvent(toDelete);
  }
}
