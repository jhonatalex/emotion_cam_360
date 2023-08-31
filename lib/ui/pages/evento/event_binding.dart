import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:get/get.dart';

class EventBinding implements Bindings {
  const EventBinding();

  @override
  void dependencies() {
    Get.lazyPut<EventController>(() => EventController());
  }
}
