import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:get/get.dart';

import '../pages/Upload_screen/upload_video_page.dart';
import '../pages/camera/camera_binding.dart';
import '../pages/camera/camera_page.dart';
import '../pages/finish_qr/finish_binding.dart';
import '../pages/finish_qr/finish_qr_page.dart';
import '../pages/home/home_binding.dart';
import '../pages/home/home_page.dart';
import '../pages/splash/splash_binding.dart';
import '../pages/splash/splash_page.dart';
import '../pages/efecto/efecto_binding.dart';
import '../pages/efecto/efecto_page.dart';
import '../pages/video_screen/video_page.dart';
import '../widgets/camera_screen.dart';
import '../widgets/show_video_page.dart';

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
        transition: Transition.cupertino,
        binding: const HomeBinding(),
      ),
      GetPage(
        name: RouteNames.menu,
        page: () => const EfectoPage(),
        transition: Transition.cupertino,
        binding: const MenuBinding(),
      ),
      GetPage(
        name: RouteNames.camera,
        page: () => const CameraPage(),
        transition: Transition.cupertino,
        binding: const CameraBinding(),
      ),
      GetPage(
        name: RouteNames.finishQr,
        page: () => const FinishQrPage(),
        transition: Transition.fadeIn,
        binding: const FinishQrBinding(),
      ),
      GetPage(
        name: RouteNames.cameraScreen,
        page: () => CameraScreen(),
        transition: Transition.fadeIn,
        //binding: const FinishBinding(),
      ),
      GetPage(
        name: RouteNames.videoScreen,
        page: () => const VideoPage(),
        transition: Transition.fadeIn,
        //binding: const FinishBinding(),
      ),
      GetPage(
        name: RouteNames.uploadVideo,
        page: () => const UploadVideoPage(),
        transition: Transition.fadeIn,
        //binding: const FinishBinding(),
      ),
    ];
  }
}
