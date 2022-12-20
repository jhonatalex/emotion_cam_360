import 'package:get/get.dart';

import 'menu_controller.dart';

class MenuBinding implements Bindings {
  const MenuBinding();

  @override
  void dependencies() {
    Get.lazyPut<MenuController>(() => MenuController());
  }
}
