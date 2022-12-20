import 'package:get/get.dart';

import 'finish_controller.dart';

class FinishBinding implements Bindings {
  const FinishBinding();

  @override
  void dependencies() {
    Get.lazyPut<FinishController>(() => FinishController());
  }
}
