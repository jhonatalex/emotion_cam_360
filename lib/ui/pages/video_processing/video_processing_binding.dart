import 'package:emotion_cam_360/ui/pages/video_processing/video_processing_controller.dart';
import 'package:get/get.dart';

class VideoProcessingBinding implements Bindings {
  const VideoProcessingBinding();

  @override
  void dependencies() {
    Get.lazyPut<VideoProcessingController>(() => VideoProcessingController());
  }
}
