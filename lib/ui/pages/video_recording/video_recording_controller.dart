import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:emotion_cam_360/ui/pages/settings/settings-controller.dart';
import 'package:get/get.dart';

class VideoRecordController extends GetxController {
  final SettingsController settingsController = Get.put(SettingsController());

  //OBSERVABLES
  Rx<Uint8List?> pickedVideo = Rx(null);
  Rx<String> videoPath = Rx('');
  Rx<bool> isLoading = Rx(false);
  Rx<bool> isSaving = Rx(false);
  Rx<VideoEntity?> video = Rx(null);

  RxDouble opacityText = 1.0.obs;
  RxDouble opacityRec = 0.0.obs;

  //RxBool isRecording = false.obs; // Bandera indicadora de grabación en proceso
  late List<CameraDescription> cameras; // Lista de cámaras disponibles
  Rx<CameraController?> controller = Rx(null); // Controlador de la cámara
  RxInt start = 10.obs;
  //el tiempo que se configuró más los 10seg para empezar

}
