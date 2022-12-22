import 'dart:io';

import 'package:emotion_cam_360/entities/video.dart';

abstract class VideoRepository {
  //Future<MyUser?> getMyUser();

  Future<void> saveMyVideoRepository(VideoEntity videoEntity, File? video);
}
