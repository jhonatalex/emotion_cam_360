import 'package:emotion_cam_360/ui/pages/Upload_screen/upload_video_controller.dart';
import 'package:get/get.dart';

class UploadVideoBinding implements Bindings {
  const UploadVideoBinding();

  @override
  void dependencies() {
    Get.lazyPut<UploadVideoController>(
      () => UploadVideoController(),
    );
  }
}
