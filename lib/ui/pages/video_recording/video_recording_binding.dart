import 'package:emotion_cam_360/repositories/abstractas/video_repository.dart';
import 'package:get/get.dart';

import 'video_recording_controller.dart';

class VideoBinding implements Bindings {
  const VideoBinding();

  @override
  void dependencies() {
    Get.lazyPut<VideoController>(() => VideoController());
  }
}
