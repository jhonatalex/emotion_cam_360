import 'package:emotion_cam_360/ui/pages/video_processing/video_processing_page.dart';
import 'package:emotion_cam_360/ui/pages/video_recording/video_recording_page.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:get/get.dart';

import '../pages/Upload_screen/upload_video_binding.dart';
import '../pages/Upload_screen/upload_video_page.dart';

import '../pages/finish_qr/finish_binding.dart';
import '../pages/finish_qr/finish_qr_page.dart';
import '../pages/home/home_binding.dart';
import '../pages/home/home_page.dart';
import '../pages/splash/splash_binding.dart';
import '../pages/splash/splash_page.dart';
import '../pages/efecto/efecto_binding.dart';
import '../pages/efecto/efecto_page.dart';
import '../pages/video_recording/video_recording_binding.dart';
import '../pages/video_screen/video_page.dart';
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
        name: RouteNames.efecto,
        page: () => const EfectoPage(),
        transition: Transition.cupertino,
        binding: const EfectoBinding(),
      ),
      GetPage(
        name: RouteNames.finishQr,
        page: () => const FinishQrPage(),
        transition: Transition.fadeIn,
        binding: const FinishQrBinding(),
      ),
      GetPage(
        name: RouteNames.videoPage,
        page: () => const VideoPage(),
        transition: Transition.fadeIn,
        binding: const VideoBinding(),
      ),
      GetPage(
        name: RouteNames.uploadVideo,
        page: () => UploadVideoPage(),
        transition: Transition.fadeIn,
        binding: const UploadVideoBinding(),
      ),
      GetPage(
        name: RouteNames.videoRecording,
        page: () => const VideoRecordingPage(),
        transition: Transition.fadeIn,
        binding: const VideoBinding(),
      ),
      GetPage(
        name: RouteNames.showVideo,
        page: () => const ShowVideoPage(
          filePath: '',
        ),
        transition: Transition.fadeIn,
        //binding: const FinishBinding(),
      ),
      GetPage(
        name: RouteNames.videoProcessing,
        page: () => const VideoProcessingPage(
            // filePath: '',
            ),
        transition: Transition.fadeIn,
        //binding: const FinishBinding(),
      ),
    ];
  }
}
