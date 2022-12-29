import 'package:get/get.dart';

import 'efecto_controller.dart';

class EfectoBinding implements Bindings {
  const EfectoBinding();

  @override
  void dependencies() {
    Get.lazyPut<EfectoPageController>(() => EfectoPageController());
  }
}
