import 'package:emotion_cam_360/controllers/auth_controller.dart';
import 'package:emotion_cam_360/repositories/abstractas/auth_repositoryAbst.dart';
import 'package:emotion_cam_360/repositories/abstractas/event_repository.dart';
import 'package:emotion_cam_360/repositories/abstractas/video_repository.dart';
import 'package:emotion_cam_360/repositories/implementations/auth_repositoryImp.dart';
import 'package:emotion_cam_360/repositories/implementations/event_repositoryImple.dart';
import 'package:emotion_cam_360/repositories/implementations/video_repositoryImpl.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  const AppBinding();

  @override
  void dependencies() {
    Get.put<VideoRepository>(VideoRepositoryImp(), permanent: true);
    Get.put<AuthRepository>(AuthRepositoryImp(), permanent: true);
    Get.put<EventRepository>(EventRepositoryImple(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
