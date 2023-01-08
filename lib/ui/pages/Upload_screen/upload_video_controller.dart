import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:get/get.dart';

import '../../../repositories/abstractas/video_repository.dart';
import '../../routes/route_names.dart';

class UploadVideoController extends GetxController {
  final _videoRepository = Get.find<VideoRepository>();

  //OBSERVABLES
  final RxBool loading = RxBool(true);
  Rx<bool> isSaving = Rx(false);
  Rx<VideoEntity?> video = Rx(null);
  Rx<String> urlVideoObserver = Rx('');

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> saveMyVideoController(videoByte, videoPath, eventoActual) async {
    isSaving.value = true;
    loading.value = true;

    print(chalk.brightGreen('ENTRO AL CONTROLLER'));

    urlVideoObserver.value = await _videoRepository.saveMyVideoRepository(
        videoByte, videoPath, eventoActual);

    //urlVideoObserver.value = urlOfVideo;
    isSaving.value = false;
    loading.value = false;
  }
}
