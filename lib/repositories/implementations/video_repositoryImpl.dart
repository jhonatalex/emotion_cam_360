import 'dart:io';
import 'dart:typed_data';

import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/firebase_provider-db.dart';
import '../../entities/user.dart';
import '../abstractas/video_repository.dart';

class VideoRepositoryImp extends VideoRepository {
  final provider = FirebaseProvider();

  //@override
  //Future<MyUser?> getMyUser() => provider.getMyUser();

  @override
  Future<String> saveMyVideoRepository(
      Uint8List? video, String videoPath, EventEntity eventoActual) async {
    return provider.saveMyVideoProvider(video, videoPath, eventoActual);
  }
}
