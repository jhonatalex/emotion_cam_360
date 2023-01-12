import 'dart:typed_data';

import 'package:emotion_cam_360/controllers/auth_controller.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/repositories/abstractas/auth_repositoryAbst.dart';
import 'package:emotion_cam_360/repositories/abstractas/event_repository.dart';
import 'package:emotion_cam_360/repositories/abstractas/video_repository.dart';
import 'package:emotion_cam_360/repositories/implementations/auth_repositoryImp.dart';
import 'package:emotion_cam_360/repositories/implementations/event_repositoryImple.dart';
import 'package:emotion_cam_360/repositories/implementations/video_repositoryImpl.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AppBinding implements Bindings {
  const AppBinding();

  @override
  void dependencies() {
    Get.put<VideoRepository>(VideoRepositoryImp(), permanent: true);
    Get.put<AuthRepository>(AuthRepositoryImp(), permanent: true);
    Get.put<EventRepository>(EventRepositoryImple(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}

class SesionPreferencerProvider with ChangeNotifier {
  String _user = '';

  get users {
    return _user;
  }

  set user(String nombre) {
    this._user = nombre;
    notifyListeners();
  }

  void saveUser(String? email) {
    this._user = email!;
    notifyListeners();
  }
}

class EventoActualPreferencesProvider with ChangeNotifier {
  EventEntity? _eventEntity = null;

  get eventPrefrerences {
    return _eventEntity;
  }

  set eventPrefrerence(EventEntity entity) {
    this._eventEntity = entity;
    notifyListeners();
  }

  void saveEventPrefrerence(EventEntity entity) {
    this._eventEntity = entity;
    notifyListeners();
  }
}

class VideoPreferencesProvider with ChangeNotifier {
  Uint8List? _video = null;
  String _path = '';

  get videoPreferences {
    return _video;
  }

  /*  set videoPrefrerence(Uint8List video) {
    this._video = video;
    notifyListeners();
  }
 */
  void saveVideoPrefrerence(Uint8List video) {
    this._video = video;
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
    this._path = path;
    notifyListeners();
  }
}
