// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/ui/pages/efecto/efecto_page.dart';
import 'package:emotion_cam_360/ui/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

import '../../../repositories/abstractas/appcolors.dart';
import '../../../repositories/abstractas/responsive.dart';
import '../../routes/route_names.dart';
import '../../widgets/countdow.dart';
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
  int endTime = 0;
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
  }

  _initCamera(CameraDescription camera) async {
    // Si el controlador está en uso,
    // realizar un dispose para detenerlo antes de continuar
    if (_controller != null) await _controller!.dispose();
    // Indicar al controlador la nueva cámara a utilizar
    _controller = CameraController(camera, ResolutionPreset.medium);
    // Agregar un Listener para refrescar la pantalla en cada cambio
    _controller!.addListener(() => this.setState(() {}));
    // Inicializar el controlador
    _controller!.initialize();

    //Inicia la grabacion
  }

  Widget _buildCamera() {
    // desplegar un mensaje al usuario y evitar mostrar una cámara sin inicializar
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: Text('Loading...'));
    }
    // Utilizar un Widget de tipo AspectRatio para desplegar el alto y ancho correcto
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
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

      print(chalk.brightGreen(file!.path));

      //PASAR DATA CON GETX
      Get.to(
        () => ShowVideoPage(filePath: file.path),
        transition: Transition.circularReveal,
        arguments: file,
      );

      /* 
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => ShowVideoPage(filePath: file!.path),
   
        Navigator.push(context, route);
      );   
      */

    } else {
      print("ENTRO GRABAR");
      await _controller?.prepareForVideoRecording();
      await _controller?.startVideoRecording();
      setState(() => _isRecording = true);
    }
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
        body: Stack(children: [
          Center(child: _buildCamera()),
          Center(child: FloatingActionButton(onPressed: () async {
            _recordVideo();
            setState(() {});
          }))
        ]),
      ),
    );
  }
}
