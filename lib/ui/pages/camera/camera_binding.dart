import 'package:emotion_cam_360/repositories/abstractas/video_repository.dart';
import 'package:get/get.dart';

import 'camera_controller.dart';

class CameraBinding implements Bindings {
  const CameraBinding();

  @override
  void dependencies() {
    Get.lazyPut<CamaraVideoController>(() => CamaraVideoController());
  }
}
