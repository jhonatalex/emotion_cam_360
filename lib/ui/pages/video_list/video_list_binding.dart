import 'package:get/get.dart';

import 'video_list_controller.dart';

class VideoListBinding implements Bindings {
  const VideoListBinding();

  @override
  void dependencies() {
    Get.lazyPut<VideoListController>(() => VideoListController());
  }
}
