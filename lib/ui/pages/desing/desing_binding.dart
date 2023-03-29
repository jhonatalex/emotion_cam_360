import 'package:get/get.dart';

import 'desing_controller.dart';

class DesingBinding implements Bindings {
  const DesingBinding();

  @override
  void dependencies() {
    Get.lazyPut<DesingController>(() => DesingController());
  }
}
