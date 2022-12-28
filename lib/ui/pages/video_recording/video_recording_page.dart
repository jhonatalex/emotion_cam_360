import 'dart:async';

import 'package:camera/camera.dart';
import 'package:emotion_cam_360/ui/pages/efecto/efecto_page.dart';
import 'package:emotion_cam_360/ui/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

import '../../../repositories/abstractas/appcolors.dart';
import '../../../repositories/abstractas/responsive.dart';
import '../../routes/route_names.dart';
import '../../widgets/show_video_page.dart';

class VideoRecordingPage extends StatefulWidget {
  const VideoRecordingPage({super.key});

  @override
  State<VideoRecordingPage> createState() => _VideoRecordingPageState();
}

class _VideoRecordingPageState extends State<VideoRecordingPage> {
  //Variables
  late List<CameraDescription> _cameras; // Lista de cámaras disponibles
  CameraController? _controller; // Controlador de la cámara
  int _cameraIndex = 1; // Índice de cámara actual
  bool _isRecording = false; // Bandera indicadora de grabación en proceso

  double _opacity = 1.0;
  double _width = 15;
  bool _isFirst = true;
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();

    // Verificar la lista de cámaras disponibles al iniciar el Widget
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
    });
    //iniciar temporizador
    startTimer();
  }

  _initCamera(CameraDescription camera) async {
    // Si el controlador está en uso,
    // realizar un dispose para detenerlo antes de continuar
    if (_controller != null) await _controller!.dispose();
    // Indicar al controlador la nueva cámara a utilizar
    _controller = CameraController(camera, ResolutionPreset.medium);
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
        aspectRatio: 16 / 22,
        child: CameraPreview(_controller!),
      ),
    );
  }

  // Detener la grabación de video
  Future<void> _onStop() async {
    await _controller?.stopVideoRecording();
    setState(() => _isRecording = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      print("PARO DE GRABAR");
      final file = await _controller?.stopVideoRecording();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => ShowVideoPage(filePath: file!.path),
      );
      Navigator.push(context, route);
    } else {
      print("ENTRO GRABAR");
      await _controller?.prepareForVideoRecording();
      await _controller?.startVideoRecording();

      setState(() => _isRecording = true);
    }
  }

  late Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 1) {
          setState(() {
            _opacity = 0;
            _recordVideo();
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: sclH(context) * 7,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: sclH(context) * 3,
            onPressed: (() => Get.offNamed(RouteNames.home)),
          ),
        ),
        backgroundColor: AppColors.vulcan,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [_buildCamera(), CountDown(context), buttonRec()],
            ),
          ],
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: () async => {_recordVideo()}),
      ),
    );
  }

  AnimatedOpacity buttonRec() {
    return AnimatedOpacity(
      opacity: _opacity,
      curve: Curves.easeInToLinear,
      duration: Duration(seconds: 1),
      onEnd: () => _opacity == 0 ? 1 : 0,
      child: Positioned(
          top: 5,
          right: 5,
          child: Icon(
            Icons.radio_button_checked,
            color: Colors.red,
          )),
    );
  }

  AnimatedOpacity CountDown(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      curve: Curves.easeInToLinear,
      duration: Duration(milliseconds: 500),
      child: Column(
        children: [
          Text(
            'Preparate...',
            style: TextStyle(fontSize: sclH(context) * 3),
          ),
          Text(
            "$_start",
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
  }
}
