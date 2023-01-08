import 'package:get/get.dart';

import '../../routes/route_names.dart';

class SplashController extends GetxController {
  //final RxBool _loading = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 2));

    Get.offNamed(RouteNames.signIn);
  }
}
