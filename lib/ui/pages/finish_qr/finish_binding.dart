import 'package:get/get.dart';

import 'finish_controller.dart';

class FinishQrBinding implements Bindings {
  const FinishQrBinding();

  @override
  void dependencies() {
    Get.lazyPut<FinishQrController>(() => FinishQrController());
  }
}
