import 'package:get/get.dart';

import 'camera_controller.dart';

class CameraBinding implements Bindings {
  const CameraBinding();

  @override
  void dependencies() {
    Get.lazyPut<CameraController>(() => CameraController());
  }
}
