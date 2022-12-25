import 'dart:io';
import 'dart:typed_data';

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
  Future<void> saveMyVideoRepository(
      // ignore: avoid_renaming_method_parameters
      VideoEntity videoentity,
      Uint8List? video) async {
    provider.saveMyVideoProvider(videoentity, video);
  }
}
