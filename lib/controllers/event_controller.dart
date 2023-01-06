import 'dart:async';
import 'dart:io';
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

  @override
  void onInit() {
    getMyUser();
    super.onInit();
  }

  void setImage(File? imageFileLogo) async {
    pickedImageLogo.value = imageFileLogo;
  }

  Future<void> getMyUser() async {
    isLoading.value = true;
    user.value = await provider.getMyUser();
    isLoading.value = false;
  }

  Future<void> saveMyEvent() async {
    isSaving.value = true;
    final DateTime now = DateTime.now();
    final int millSeconds = now.millisecondsSinceEpoch;
    final uid = nameController.text; // + millSeconds.toString();
    final name = nameController.text;
    final musica = musicController.text;

    final newEvent =
        EventEntity(uid, name, musica, overlay: pickedImageLogo.value!.path);

    evento.value = newEvent;

    // For testing add delay
    //await Future.delayed(const Duration(seconds: 3));
    await _eventRepository.saveMyEvento(newEvent, pickedImageLogo.value);

    isSaving.value = false;
  }
}
