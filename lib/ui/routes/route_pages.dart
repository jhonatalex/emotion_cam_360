import 'package:emotion_cam_360/ui/pages/evento/event_binding.dart';
import 'package:emotion_cam_360/ui/pages/evento/event_page.dart';
import 'package:emotion_cam_360/ui/pages/login/profile_page.dart';
import 'package:emotion_cam_360/ui/pages/login/signIn_page.dart';
import 'package:emotion_cam_360/ui/pages/video_list/video_list_binding.dart';
import 'package:emotion_cam_360/ui/pages/video_list/video_list_page.dart';
import 'package:emotion_cam_360/ui/pages/video_processing/video_processing_page.dart';
import 'package:emotion_cam_360/ui/pages/video_recording/video_recording_page.dart';
import 'package:emotion_cam_360/ui/pages/video_viewer/video_viewer_binding.dart';
import 'package:emotion_cam_360/ui/pages/video_viewer/video_viewer_page.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:get/get.dart';

import '../pages/Upload_screen/upload_video_binding.dart';
import '../pages/Upload_screen/upload_video_page.dart';

import '../pages/finish_qr/finish_binding.dart';
import '../pages/finish_qr/finish_qr_page.dart';
import '../pages/home/home_binding.dart';
import '../pages/home/home_page.dart';
import '../pages/login/signUp_page.dart';
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
        page: () => HomePage(),
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
        page: () => FinishQrPage(),
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
      GetPage(
        name: RouteNames.signUp,
        page: () => const SignUpPage(),
        transition: Transition.fadeIn,
        //binding: const FinishBinding(),
      ),
      GetPage(
        name: RouteNames.signIn,
        page: () => SignInPage(),
        transition: Transition.fadeIn,
        //binding: const FinishBinding(),
      ),
      GetPage(
        name: RouteNames.profile,
        page: () => const ProfilePage(),
        transition: Transition.fadeIn,
        //binding: const FinishBinding(),
      ),
      GetPage(
        name: RouteNames.eventPage,
        page: () => const EventPage(),
        transition: Transition.fadeIn,
        binding: const EventBinding(),
      ),
      GetPage(
        name: RouteNames.videoListPage,
        page: () => VideoListPage(),
        transition: Transition.fadeIn,
        binding: const VideoListBinding(),
      ),
      GetPage(
        name: RouteNames.videoViewerPage,
        page: () => VideoViewerPage(),
        transition: Transition.fadeIn,
        binding: const VideoViewerBinding(),
      ),
    ];
  }
}
