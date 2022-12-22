import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repositories/abstractas/video_repository.dart';

class CamaraVideoController extends GetxController {
  final _videoRepository = Get.find<VideoRepository>();

  Rx<File?> pickedVideo = Rx(null);
  Rx<bool> isLoading = Rx(false);
  Rx<bool> isSaving = Rx(false);
  Rx<VideoEntity?> video = Rx(null);

  @override
  void onInit() {
    //getMyUser();
    super.onInit();
  }

  void setVideo(File? videoFile) async {
    pickedVideo.value = videoFile;
  }

  Future<void> saveVideo(
      String videoPath, Future<Uint8List> readAsBytes) async {
    isSaving.value = true;

    final newVideo = VideoEntity('1', videoPath, video: video.value?.video);
    video.value = newVideo;

    // For testing add delay
    //await Future.delayed(const Duration(seconds: 3));
    //VOY AL REPOSITORIO LUEGO AL PROVIDER

    await _videoRepository.saveMyVideoRepository(newVideo, pickedVideo.value);
    isSaving.value = false;
  }

  /// Devuelve un icono de cámara adecuado para [dirección] .
  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
    }
    throw ArgumentError('Unknown lens direction');
  }

  static openCamaraVideo() {}
}
