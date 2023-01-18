import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/repositories/abstractas/event_repository.dart';
import 'package:get/get.dart';

import '../../../repositories/implementations/event_repositoryImple.dart';

class EventBinding implements Bindings {
  const EventBinding();

  @override
  void dependencies() {
    Get.lazyPut<EventController>(() => EventController());
  }
}
