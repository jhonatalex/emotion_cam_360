import 'package:get/get.dart';

import 'video_recording_controller.dart';

class VideoBinding implements Bindings {
  const VideoBinding();

  @override
  void dependencies() {
    Get.lazyPut<VideoRecordController>(() => VideoRecordController());
  }
}
