import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../repositories/abstractas/video_repository.dart';

class VideoController extends GetxController {
  //OBSERVABLES
  Rx<Uint8List?> pickedVideo = Rx(null);
  Rx<bool> isLoading = Rx(false);
  Rx<bool> isSaving = Rx(false);
  Rx<VideoEntity?> video = Rx(null);
}
