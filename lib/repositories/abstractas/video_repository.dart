import 'dart:typed_data';

import 'package:emotion_cam_360/entities/responseFirebase.dart';

import '../../entities/event.dart';

abstract class VideoRepository {
  //Future<MyUser?> getMyUser();

  Future<Responsefirebase?> saveMyVideoRepository(
      Uint8List? video, String videoPath, EventEntity eventoActual);
}
