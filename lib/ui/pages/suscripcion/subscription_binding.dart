import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/ui/pages/suscripcion/subscription_controller.dart';
import 'package:get/get.dart';

import '../../../data/firebase_provider-db.dart';

class SubscriptionBinding implements Bindings {
  const SubscriptionBinding();

  @override
  void dependencies() {
    Get.lazyPut<FirebaseProvider>(
      () => FirebaseProvider(),
    );

    Get.lazyPut<EventController>(
      () => EventController(),
    );

      Get.lazyPut<SubscriptionController>(
      () => SubscriptionController(),
    );
  }
}
