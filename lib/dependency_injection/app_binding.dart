import 'package:emotion_cam_360/repositories/abstractas/video_repository.dart';
import 'package:emotion_cam_360/repositories/implementations/video_repositoryImpl.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  const AppBinding();

  @override
  void dependencies() {
    Get.put<VideoRepository>(VideoRepositoryImp(), permanent: true);
  }
}
