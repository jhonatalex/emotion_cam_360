import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/entities/video.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../repositories/abstractas/video_repository.dart';

class VideoController extends GetxController {
  //OBSERVABLES
  Rx<Uint8List?> pickedVideo = Rx(null);
  Rx<String> videoPath = Rx('');
  Rx<bool> isLoading = Rx(false);
  Rx<bool> isSaving = Rx(false);
  Rx<VideoEntity?> video = Rx(null);

  RxDouble opacityText = 1.0.obs;
  RxDouble opacityRec = 0.0.obs;

  RxBool isRecording = false.obs; // Bandera indicadora de grabación en proceso
  int timeSelected = 10; //Variables
  late List<CameraDescription> cameras; // Lista de cámaras disponibles
  Rx<CameraController?> controller = Rx(null); // Controlador de la cámara
  int cameraIndex = 1; // Índice de cámara actual
  RxInt start = 10.obs;
  //el tiempo que se configuró más los 10seg para empezar

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // Verificar la lista de cámaras disponibles al iniciar el Widget
    /*  availableCameras().then((cameras) {
      // Guardar la lista de cámaras
      cameras = cameras;
      // Inicializar la cámara solo si la lista de cámaras tiene cámaras disponibles
      if (cameras.length != 0) {
        // Inicializar el índice de cámara actual en 0 para obtener la primera
        cameraIndex = 1;
        // Inicializar la cámara pasando el CameraDescription de la cámara seleccionada
        initCamera(cameras[cameraIndex]);
      }
    }); */
    //iniciar temporizador
    //startTimer();
  }

  /* initCamera(CameraDescription camera) async {
    // Si el controlador está en uso,
    // realizar un dispose para detenerlo antes de continuar
    Future<void> disposeCameraController() async {
      if (controller == null) {
        return Future.value();
      }

      final cameraController = controller;

      controller.value = null;

      // Wait for the post frame callback.
      final completerPostFrameCallback = Completer<Duration>();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        completerPostFrameCallback.complete(timeStamp);
      });
      await completerPostFrameCallback.future;

      return cameraController.value?.dispose();
    }

    //hacer dispose con el codigo anterior
    //me costo resolver ese problema
    // Indicar al controlador la nueva cámara a utilizar
    controller.value = CameraController(camera, ResolutionPreset.high);
    // Agregar un Listener para refrescar la pantalla en cada cambio
    controller.value!.addListener(() {
      start.value > 5 ? !isRecording.value : "";
    });
    // Inicializar el controlador
    controller.value!.initialize();
  }
 */
  /* buildCamera() {
    // desplegar un mensaje al usuario y evitar mostrar una cámara sin inicializar
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(child: Text('Loading...'));
    }
    // Utilizar un Widget de tipo AspectRatio para desplegar el alto y ancho correcto
    return Center(
      child: AspectRatio(
        aspectRatio: 9 / 16, // 16 / 22,
        child: CameraPreview(controller!),
      ),
    );
  }
 */
  /*  // Detener la grabación de video
  Future<void> onStop() async {
    final file = await controller.value?.stopVideoRecording();
    isRecording.value = false;

    //CAMBIAR ACA SALTAR VIDEO
    //READ BYTES AND SEND DATA WITH GETX
    await file!
        .readAsBytes()
        .then((valueBytes) => pickedVideo.value = valueBytes);
    videoPath.value = file.path;
  }

  recordVideo() async {
    await controller.value?.prepareForVideoRecording();
    await controller.value?.startVideoRecording();

    isRecording.value = true;
  } */

  /*  startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 2) {
          print("es dos");
          opacityText.value = 0;
        }
        if (start == 0) {
          print("es cero");
          opacityRec.value = 1;
          recordVideo();
        }
        if (start == -timeSelected) {
          //los 10 segundos de espera son +
          //y de ahi en adelante son los de grabación
          print("es -timeselected");
          onStop();
          timer.cancel();
          /*  setState(() {
            onStop();
          }); */
        } else {
          start--;
          print(-start);
        }
      },
    );
  } */
}
