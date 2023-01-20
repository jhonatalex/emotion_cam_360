import 'package:get/get.dart';

import 'video_viewer_controller.dart';

class VideoViewerBinding implements Bindings {
  const VideoViewerBinding();

  @override
  void dependencies() {
    Get.lazyPut<VideoViewerController>(() => VideoViewerController());
  }
}
