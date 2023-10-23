// ignore_for_file: avoid_print
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/ui/pages/video_processing/video_util.dart';
import 'package:emotion_cam_360/ui/pages/video_recording/video_recording_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/appcolors.dart';
import '../../widgets/responsive.dart';
import '../../routes/route_names.dart';

class VideoRecordingPage extends StatefulWidget {
  const VideoRecordingPage({super.key});

  @override
  State<VideoRecordingPage> createState() => _VideoRecordingPageState();
}

class _VideoRecordingPageState extends State<VideoRecordingPage> {
  //Variables

  final VideoRecordController vRCtrl = Get.find<VideoRecordController>();
  late List<CameraDescription> _cameras; // Lista de cámaras disponibles
  CameraController? _controller; // Controlador de la cámara
  int _cameraIndex = 1; // Índice de cámara actual
  late int startTime;
  // bool _isRecording = false; Bandera indicadora de grabación en proceso
/* 
  double _opacityText = 1.0;
  double _opacityRec = 0;
  double _width = 15;
  bool _isFirst = true;
  int _selectedIndex = 2;
  int _timeSelected = 10; // tiempo seleccionado por el usuario */

  @override
  void initState() {
    super.initState();

    // Verificar la lista de cámaras disponibles al iniciar el Widget
    availableCameras().then((cameras) {
      // Guardar la lista de cámaras
      _cameras = cameras;
      // Inicializar la cámara solo si la lista de cámaras tiene cámaras disponibles
      if (_cameras.isNotEmpty) {
        //_cameras.length != 0
        // Inicializar el índice de cámara actual en 0 para obtener la primera
        _cameraIndex = vRCtrl.settingsController.cameraIndex.value;
        // Inicializar la cámara pasando el CameraDescription de la cámara seleccionada
        _initCamera(_cameras[_cameraIndex]);
      }
    });
    //iniciar temporizador
    startTimer();

    print(chalk.white.bold(desingController.currentMarco.value));
  }

  _initCamera(CameraDescription camera) async {
    // Si el controlador está en uso,
    // realizar un dispose para detenerlo antes de continuar
    /* Future<void> _disposeCameraController() async {
      if (_controller == null) {
        return Future.value();
      }

      final cameraController = _controller;

      _controller = null;
      if (mounted) {
        setState(() {});

        // Wait for the post frame callback.
        final completerPostFrameCallback = Completer<Duration>();
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          completerPostFrameCallback.complete(timeStamp);
        });
        await completerPostFrameCallback.future;
      }

      return cameraController!.dispose();
    } */

    // Indicar al controlador la nueva cámara a utilizar
    _controller = CameraController(camera, ResolutionPreset.high);
    // Agregar un Listener para refrescar la pantalla en cada cambio
    _controller!.addListener(() => setState(() {}));
    // Inicializar el controlador
    _controller!.initialize();
  }

  Widget _buildCamera() {
    // desplegar un mensaje al usuario y evitar mostrar una cámara sin inicializar
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Center(child: Text('Loading...'));
    }
    // Utilizar un Widget de tipo AspectRatio para desplegar el alto y ancho correcto
    return Center(
      child: AspectRatio(
        aspectRatio: 9 / 16, // 16 / 22,
        child: CameraPreview(_controller!),
      ),
    );
  }

  // Detener la grabación de video
  Future<void> _onStop() async {
    final file = await _controller?.stopVideoRecording();
    /* print(chalk.white.bold(file!.mimeType));
    print(chalk.white.bold(file.name));
    print(chalk.white.bold(file.path));
    print(chalk.white.bold("Pasar de pantalla")); */
    //READ BYTES AND SEND DATA WITH GETX

    file!.readAsBytes().then((valueBytes) =>
        Get.offNamed(RouteNames.videoProcessing, arguments: file.path));
    //videoProvider.savePathPrefrerence(videoController.videoPath.value);

    // Get.offNamed(RouteNames.showVideo, arguments: file.path));

    //subir video de una vez para compararlos***
    //**********************************
/* 
    final _evenController = Get.find<EventController>();

    final videoProvider =
        Provider.of<VideoPreferencesProvider>(context, listen: false);
    final eventProvider =
        Provider.of<EventoActualPreferencesProvider>(context, listen: false);

    _evenController.uploadVideoToFirebase(videoProvider.videoPreferences,
        file.path, eventProvider.eventPrefrerences); */
  }

  _recordVideo() async {
    await _controller?.prepareForVideoRecording();
    await _controller?.startVideoRecording();

    Future.delayed(
        Duration(seconds: vRCtrl.settingsController.timeRecord.value), () {
      _onStop();
    });
  }

  void startTimer() {
    startTime = vRCtrl.settingsController.timeRecord.value;

    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (startTime == 2) {
          vRCtrl.opacityText.value = 0;
        }
        if (startTime == 0) {
          timer.cancel();
          vRCtrl.opacityRec.value = 1;
          _recordVideo();
        } else {
          setState(() {
            startTime--;
          });
          print(chalk.white.bold(startTime));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    vRCtrl.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: sclH(context) * 7,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: sclH(context) * 3,
          onPressed: (() => Get.offNamed(RouteNames.videoPage)),
        ),
        actions: [
          buttonRec(),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: AppColors.vulcan,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          _buildCamera(),
          textCountDown(context, startTime),
        ],
      ),
    );
  }

  buttonRec() {
    int i = 0;
    return Obx(() {
      return AnimatedOpacity(
        opacity: vRCtrl.opacityRec.value,
        duration: const Duration(seconds: 1),
        onEnd: () {
          i++;

          vRCtrl.opacityRec.value = vRCtrl.opacityRec.value == 0 ? 1.0 : 0.0;
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const Icon(
              Icons.circle_outlined,
              color: Colors.red,
              size: 30,
            ),
            const Icon(
              Icons.circle,
              color: Colors.red,
              size: 18,
            ),
            Text("$i"), //Temporal
          ],
        ),
      );
    });
  }

  textCountDown(BuildContext context, startTime) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return Center(
            child: AnimatedOpacity(
              opacity: vRCtrl.opacityText.value,
              curve: Curves.easeInToLinear,
              duration: const Duration(milliseconds: 500),
              child: Column(
                children: [
                  Text(
                    'Preparate...',
                    style: TextStyle(fontSize: sclH(context) * 3),
                  ),
                  Text(
                    "$startTime",
                    style: TextStyle(fontSize: sclH(context) * 20),
                  ),
                  Text(
                    'La aventura está por comenzar...',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: sclH(context) * 4),
                  ),
                ],
              ),
            ),
          );
        })
      ],
    );
  }
}
