import 'dart:async';
import 'dart:io';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/data/firebase_provider-db.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/user.dart';
import '../repositories/abstractas/event_repository.dart';
import 'auth_controller.dart';

class EventController extends GetxController {
  final _eventRepository = Get.find<EventRepository>();
  final provider = FirebaseProvider();
  final nameController = TextEditingController();
  final musicController = TextEditingController();
  Rx<File?> pickedImageLogo = Rx(null);

  Rx<bool> isLoading = Rx(false);
  Rx<bool> isSaving = Rx(false);
  Rx<EventEntity?> evento = Rx(null);
  Rx<MyUser?> user = Rx(null);

  final eventos = [].obs;

  Rx<EventEntity?> eventoSelected = Rx(null);

  @override
  void onInit() {
    loadInitialData();
    super.onInit();
  }

  void setImage(File? imageFileLogo) async {
    pickedImageLogo.value = imageFileLogo;
  }

  Future<void> saveMyEvent() async {
    isSaving.value = true;
    final DateTime now = DateTime.now();

    final String month = now.month.toString();
    final String day = now.day.toString();
    final String year = now.year.toString();

    final String today = ('$day-$month-$year');
    final uid = "${nameController.text.trim()}_fecha_$today";
    final name = nameController.text;
    final musica = musicController.text;

    final newEvent =
        EventEntity(uid, name, musica, overlay: pickedImageLogo.value!.path);
    //evento.value = newEvent;
    //TO REPOSITORY
    await _eventRepository.saveMyEvento(newEvent, pickedImageLogo.value);

    isSaving.value = false;
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
    //eventos.value = await _eventRepository.getAllEvents();
    eventos.value = await _eventRepository.getAllMyEventFirebase();
    print(chalk.yellowBright('LISTA DE VENTOS DE FIREBASE ${eventos.value}'));
    isLoading.value = false;
  }

  Future<void> getUser() async {
    if (isLoading.isTrue) return;
    isLoading.value = true;
    final newEvent = await _eventRepository.getNewEvent();
    eventos.insert(0, newEvent);
    isLoading.value = false;
  }

  Future<void> deleteUser(EventEntity toDelete) async {
    eventos.remove(toDelete);
    _eventRepository.deleteEvent(toDelete);
  }
}
