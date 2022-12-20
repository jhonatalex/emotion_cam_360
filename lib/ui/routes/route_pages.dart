import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:get/get.dart';

import '../pages/camera/camera_binding.dart';
import '../pages/camera/camera_page.dart';
import '../pages/finish/finish_binding.dart';
import '../pages/finish/finish_page.dart';
import '../pages/home/home_binding.dart';
import '../pages/home/home_page.dart';
import '../pages/splash/splash_binding.dart';
import '../pages/splash/splash_page.dart';
import '../pages/menu/menu_binding.dart';
import '../pages/menu/menu_page.dart';

class RoutePages {
  const RoutePages._();

  static List<GetPage<dynamic>> get all {
    return [
      GetPage(
        name: RouteNames.splash,
        page: () => const SplashPage(),
        binding: const SplashBinding(),
      ),
      GetPage(
        name: RouteNames.home,
        page: () => const HomePage(),
        transition: Transition.circularReveal,
        binding: const HomeBinding(),
      ),
      GetPage(
        name: RouteNames.menu,
        page: () => const MenuPage(),
        transition: Transition.circularReveal,
        binding: const MenuBinding(),
      ),
      GetPage(
        name: RouteNames.camera,
        page: () => const CameraPage(),
        transition: Transition.circularReveal,
        binding: const CameraBinding(),
      ),
      GetPage(
        name: RouteNames.finish,
        page: () => const FinishPage(),
        transition: Transition.circularReveal,
        binding: const FinishBinding(),
      ),
    ];
  }
}
