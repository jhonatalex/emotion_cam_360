import 'package:get/get.dart';

import 'efecto_controller.dart';

class MenuBinding implements Bindings {
  const MenuBinding();

  @override
  void dependencies() {
    Get.lazyPut<MenuController>(() => MenuController());
  }
}
