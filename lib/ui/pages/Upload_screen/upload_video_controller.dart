import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:get/get.dart';

import '../../../repositories/abstractas/video_repository.dart';
import '../../routes/route_names.dart';

class UploadVideoController extends GetxController {
  final _videoRepository = Get.find<VideoRepository>();

  //OBSERVABLES
  //final RxBool _loading = RxBool(true);
  Rx<bool> isSaving = Rx(false);
  Rx<VideoEntity?> video = Rx(null);
  Rx<String> urlVideoObserver = Rx('');

  @override
  void onInit() {
    super.onInit();
  }

  Future<String> saveMyVideoController(videoByte, videoPath) async {
    isSaving.value = true;

    print(chalk.brightGreen('ENTRO AL CONTROLLER'));

    final DateTime now = DateTime.now();
    final int millSeconds = now.millisecondsSinceEpoch;
    final String month = now.month.toString();
    final String date = now.day.toString();
    final String storageId = (millSeconds.toString() + "360");
    final String today = ('$month-$date');

    const uid = '0001'; //Get.find<AuthController>().authUser.value!.uid;
    final name = today; //TOMAR DEL CONTROLER O SHARED PREFERENCES
    final ruta = videoPath;

    final newVideo = VideoEntity(uid, name, ruta, video: ruta);
    video.value = newVideo;

    // For testing add delay
    //await Future.delayed(const Duration(seconds: 3));
    var urlOfVideo =
        await _videoRepository.saveMyVideoRepository(newVideo, videoByte);

    print(chalk.brightGreen('LOG AQUI $urlOfVideo'));

    //urlVideoObserver.value = urlOfVideo;

    isSaving.value = false;

    return urlOfVideo;
  }

/*
    saveEventController(videoByte, videoPath) {
    isSaving.value = true;
  
      const uid = '0001'; //Get.find<AuthController>().authUser.value!.uid;
      final name = "Boda Mesi"; //TOMAR DEL CONTROLER O SHARED PREFERENCES
      final intro = "ruta intro/video.pm4";
      final overlay = "ruta intro/phot.jpg";
      final timeVideo = 5;
      final music = "ruta intro/chayane.pm3";

      final newEvent = EventEntity(uid, name, intro, overlay , timeVideo,music,
          image: user.value?.image);
      user.value = newUser;

      // For testing add delay
      //await Future.delayed(const Duration(seconds: 3));
      await _userRepository.saveMyUser(newUser, pickedImage.value);
      

    isSaving.value = false;

  }
*/

}
