import 'dart:io';
import 'dart:typed_data';

import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/firebase_provider-db.dart';

import '../abstractas/event_repository.dart';
import '../abstractas/video_repository.dart';

class EventRepositoryImple extends EventRepository {
  final provider = FirebaseProvider();

  //@override
  //Future<MyUser?> getMyUser() => provider.getMyUser();

  @override
  Future<String> saveMyVideoRepository(
      VideoEntity videoentity, Uint8List? videoBytes) async {
    return provider.saveMyVideoProvider(videoentity, videoBytes);
  }

  @override
  Future<void> saveMyEvento(EventEntity newEvent, File? imageLogo) async {
    provider.saveMyEventProvider(newEvent, imageLogo);
  }
}
