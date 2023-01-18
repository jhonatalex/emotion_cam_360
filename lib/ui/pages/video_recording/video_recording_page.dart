// ignore_for_file: avoid_print

import 'dart:async';

import 'package:camera/camera.dart';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/ui/pages/video_recording/video_recording_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../repositories/abstractas/appcolors.dart';
import '../../../repositories/abstractas/responsive.dart';
import '../../routes/route_names.dart';

class VideoRecordingPage extends StatefulWidget {
  const VideoRecordingPage({super.key});

  @override
  State<VideoRecordingPage> createState() => _VideoRecordingPageState();
}

class _VideoRecordingPageState extends State<VideoRecordingPage> {
  final VideoController videoController = Get.put(VideoController());
  /* //Variables
  late List<CameraDescription> _cameras; // Lista de cámaras disponibles
  //CameraController? _controller; // Controlador de la cámara
  int _cameraIndex = 1; // Índice de cámara actual */
  //bool _isRecording = false; // Bandera indicadora de grabación en proceso
/* 
  double _opacityText = 1.0;
  double _opacityRec = 1; */
  double _width = 15;
  bool _isFirst = true;
  int _selectedIndex =
      2; /* 
  int _timeSelected = 10;  */ // tiempo seleccionado por el usuario
  var eventCurrent;

  @override
  void initState() {
    super.initState();

    /*    // Verificar la lista de cámaras disponibles al iniciar el Widget
    availableCameras().then((cameras) {
      // Guardar la lista de cámaras
      _cameras = cameras;
      // Inicializar la cámara solo si la lista de cámaras tiene cámaras disponibles
      if (_cameras.length != 0) {
        // Inicializar el índice de cámara actual en 0 para obtener la primera
        _cameraIndex = 1;
        // Inicializar la cámara pasando el CameraDescription de la cámara seleccionada
        _initCamera(_cameras[_cameraIndex]);
      }
    }); */ /* 
    //iniciar temporizador
    startTimer(); */
  }

  /*  _initCamera(CameraDescription camera) async {
    // Si el controlador está en uso,
    // realizar un dispose para detenerlo antes de continuar
    Future<void> _disposeCameraController() async {
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
    }

    //hacer dispose con el codigo anterior
    //me costo resolver ese problema
    // Indicar al controlador la nueva cámara a utilizar
    _controller = CameraController(camera, ResolutionPreset.high);
    // Agregar un Listener para refrescar la pantalla en cada cambio
    _controller!.addListener(() => setState(() {}));
    // Inicializar el controlador
    _controller!.initialize();
  } */
/* 
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
 */
/*   // Detener la grabación de video
  Future<void> _onStop() async {
    final file = await _controller?.stopVideoRecording();
    setState(() => _isRecording = false);

    //CAMBIAR ACA SALTAR VIDEO
    //READ BYTES AND SEND DATA WITH GETX
    file!.readAsBytes().then((valueBytes) => Get.offNamed(
        RouteNames.videoProcessing,
        arguments: [valueBytes, file.path]));
    print(chalk.white.bold(file.path));

    //filePath: file!.path

/* 
    final route = MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => ShowVideoPage(filePath: file!.path),
    );
    Navigator.push(context, route); */
  }

  _recordVideo() async {
    await _controller?.prepareForVideoRecording();
    await _controller?.startVideoRecording();

    setState(() => _isRecording = true);
  } */

  /* late Timer _timer;
  int _start = 10;
  //el tiempo que se configuró más los 10seg para empezar

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 2) {
          print("es dos");
          setState(() {
            _opacityText = 0;
            _opacityRec = 0;
          });
        }
        if (_start == 0) {
          print("es cero");
          setState(() {
            _recordVideo();
          });
        }
        if (_start == -_timeSelected) {
          //los 10 segundos de espera son +
          //y de ahi en adelante son los de grabación
          print("es -timeselected");
          _onStop();
          timer.cancel();
          /*  setState(() {
            _onStop();
          }); */
        } else {
          setState(() {
            _start--;
          });
          print(-_start);
        }
      },
    );
  } 
*/
  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoPreferencesProvider>(context);

    return Obx((() {
      if (videoController.pickedVideo.value != null) {
        //videoProvider.saveVideoPrefrerence(videoController.pickedVideo.value);

        Future.delayed(const Duration(microseconds: 500), (() {
          videoProvider.savePathPrefrerence(videoController.videoPath.value);
          Get.offNamed(RouteNames.videoProcessing,
              arguments: videoController.videoPath.value);
        }));
      }

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
            Obx(() {
              return buttonRec();
            }),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        backgroundColor: AppColors.vulcan,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Obx(() {
              if (videoController.start.value == 8) {
                print(chalk.yellow.bold("**********************object"));
              }
              return videoController.buildCamera();
            }),
            CountDown(context),
          ],
        ),
      );
    }));
  }

  buttonRec() {
    print(chalk.white.bold(videoController.isRecording));
    return AnimatedOpacity(
      opacity: 1 - videoController.opacityRec,
      duration: Duration(seconds: 1),
      onEnd: () {
        videoController.opacityRec =
            videoController.opacityRec == 0 ? 1.0 : 0.0;
      },
      child: Icon(
        Icons.radio_button_checked,
        color: Colors.red,
        size: sclH(context) * 3,
      ),
    );
  }

  Column CountDown(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Obx(() {
            return AnimatedOpacity(
              opacity: videoController.opacityText,
              curve: Curves.easeInToLinear,
              duration: Duration(milliseconds: 500),
              child: Column(
                children: [
                  Text(
                    'Preparate...',
                    style: TextStyle(fontSize: sclH(context) * 3),
                  ),
                  Text(
                    "${videoController.start}",
                    style: TextStyle(fontSize: sclH(context) * 20),
                  ),
                  Text(
                    'La aventura está por comenzar...',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: sclH(context) * 4),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
