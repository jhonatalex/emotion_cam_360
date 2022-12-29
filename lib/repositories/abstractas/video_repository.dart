import 'dart:io';
import 'dart:typed_data';

import 'package:emotion_cam_360/entities/video.dart';
import 'package:image_picker/image_picker.dart';

abstract class VideoRepository {
  //Future<MyUser?> getMyUser();

  Future<String> saveMyVideoRepository(
      VideoEntity videoEntity, Uint8List? video);
}
