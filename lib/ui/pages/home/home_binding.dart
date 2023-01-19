import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/repositories/implementations/event_repositoryImple.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBinding implements Bindings {
  const HomeBinding();

  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<EventController>(() => EventController());
    // Get.lazyPut<EventRepositoryImple>(() => EventRepositoryImple());
  }
}
