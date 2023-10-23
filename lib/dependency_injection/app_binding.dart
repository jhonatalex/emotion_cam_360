import 'dart:typed_data';

import 'package:emotion_cam_360/controllers/auth_controller.dart';
import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/repositories/abstractas/auth_repositoryAbst.dart';
import 'package:emotion_cam_360/repositories/abstractas/my_user_repository.dart';
import 'package:emotion_cam_360/repositories/abstractas/video_repository.dart';
import 'package:emotion_cam_360/repositories/implementations/auth_repositoryImp.dart';
import 'package:emotion_cam_360/repositories/implementations/my_user_repository.dart';
import 'package:emotion_cam_360/repositories/implementations/video_repositoryImpl.dart';
import 'package:emotion_cam_360/ui/pages/desing/desing_controller.dart';
import 'package:emotion_cam_360/ui/pages/settings/settings-controller.dart';
import 'package:emotion_cam_360/ui/pages/suscripcion/subscription_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AppBinding implements Bindings {
  const AppBinding();

  @override
  void dependencies() {
    Get.put<VideoRepository>(VideoRepositoryImp(), permanent: true);
    Get.put<AuthRepository>(AuthRepositoryImp(), permanent: true);
    Get.put<MyUserRepository>(MyUserRepositoryImp(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<DesingController>(DesingController(), permanent: true);
    Get.put<SettingsController>(SettingsController(), permanent: true);
    Get.put<SubscriptionController>(SubscriptionController(), permanent: true);
    Get.put<EventController>(EventController(), permanent: true);
  }
}

class SesionPreferencerProvider with ChangeNotifier {
  String _user = '';

  get users {
    return _user;
  }

  set user(String nombre) {
    _user = nombre;
    notifyListeners();
  }

  void saveUser(String? email) {
    _user = email!;
    notifyListeners();
  }
}

class EventoActualPreferencesProvider with ChangeNotifier {
  EventEntity? _eventEntity;
  bool _seleccionar = false;

  get eventPrefrerences {
    return _eventEntity;
  }

  set eventPrefrerence(EventEntity entity) {
    _eventEntity = entity;
    notifyListeners();
  }

  void saveEventPrefrerence(EventEntity? entity) {
    _eventEntity = entity;
    notifyListeners();
  }

  get seleccionarPrefrerences {
    return _seleccionar;
  }

  void saveSleccionarPrefrerence(bool value) {
    _seleccionar = value;
    notifyListeners();
  }
}

class VideoPreferencesProvider with ChangeNotifier {
  Uint8List? _video;
  String _path = '';

  get videoPreferences {
    return _video;
  }

  /*  set videoPrefrerence(Uint8List video) {
    this._video = video;
    notifyListeners();
  }
 */
  void saveVideoPrefrerence(Uint8List? video) {
    _video = video;
    notifyListeners();
  }

  get pathPreferences {
    return _path;
  }

  /*  set pathPrefrerence(String path) {
    this._path = path;
    notifyListeners();
  }
 */
  void savePathPrefrerence(String path) {
    _path = path;
    notifyListeners();
  }
}
