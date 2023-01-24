import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/ui/pages/Upload_screen/upload_video_controller.dart';
import 'package:get/get.dart';

import '../../../data/firebase_provider-db.dart';

class UploadVideoBinding implements Bindings {
  const UploadVideoBinding();

  @override
  void dependencies() {
    Get.lazyPut<UploadVideoController>(
      () => UploadVideoController(),
    );
    Get.lazyPut<FirebaseProvider>(
      () => FirebaseProvider(),
    );

    Get.lazyPut<EventController>(
      () => EventController(),
    );
  }
}
