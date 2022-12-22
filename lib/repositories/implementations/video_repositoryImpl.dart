import 'dart:io';

import 'package:emotion_cam_360/entities/video.dart';

import '../../data/firebase_provider-db.dart';
import '../../entities/user.dart';
import '../abstractas/video_repository.dart';

class VideoRepositoryImp extends VideoRepository {
  final provider = FirebaseProvider();

  //@override
  //Future<MyUser?> getMyUser() => provider.getMyUser();

  @override
  Future<void> saveMyVideoRepository(
      VideoEntity videoentity, File? video) async {
    provider.saveMyVideoProvider(videoentity, video);
  }
}
