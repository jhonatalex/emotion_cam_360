import 'dart:typed_data';

import 'package:emotion_cam_360/entities/video.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  //OBSERVABLES
  Rx<Uint8List?> pickedVideo = Rx(null);
  Rx<bool> isLoading = Rx(false);
  Rx<bool> isSaving = Rx(false);
  Rx<VideoEntity?> video = Rx(null);
}
