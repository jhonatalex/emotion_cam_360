import 'dart:async';

import 'package:camera/camera.dart';
import 'package:emotion_cam_360/ui/pages/efecto/efecto_page.dart';
import 'package:emotion_cam_360/ui/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repositories/abstractas/appcolors.dart';
import '../../../repositories/abstractas/responsive.dart';
import '../../routes/route_names.dart';
import '../../widgets/countdow.dart';
import '../../widgets/show_video_page.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  //Variables
  late List<CameraDescription> _cameras; // Lista de cámaras disponibles
  CameraController? _controller; // Controlador de la cámara
  int _cameraIndex = 1; // Índice de cámara actual
  bool _isRecording = false; // Bandera indicadora de grabación en proceso
  int endTime = 0;
  bool _isFirst = true;
  int _selectedIndex = 2;
  IconData currentIcon = Icons.camera_front;
  String currentLabel = "Frontal";
  bool isCamSelected = true;

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

    //if (_controller != null) await _controller!.dispose();

    // Indicar al controlador la nueva cámara a utilizar
    _controller = CameraController(camera, ResolutionPreset.medium);
    // Agregar un Listener para refrescar la pantalla en cada cambio
    _controller!.addListener(() => setState(() {}));
    // Inicializar el controlador
    _controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
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

  // Retornar el ícono de la cámara
  IconData _getCameraIcon(CameraLensDirection lensDirection) {
    if (lensDirection == CameraLensDirection.back) {
      currentIcon = Icons.camera_rear;
      currentLabel = "Poterior";
    } else {
      currentIcon = Icons.camera_front;
      currentLabel = "Frontal";
    }
    return currentIcon;
  }

  // Cambia la cámara actual
  void _onSwitchCamera() {
    if (_cameras.length < 2) return;
    _cameraIndex = (_cameraIndex + 1) % 2;
    _initCamera(_cameras[_cameraIndex]);
    _getCameraIcon(_cameras[_cameraIndex].lensDirection);
  }

  Widget SelectActionShow(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return _buildCamera();

      case 1:
        return const Text(
          'Filtro',
          style: TextStyle(fontSize: 50),
        );
      case 2:
        return Stack(children: [
          _buildCamera(),
          /*  Center(
            child: Container(
              height: sclH(context) * 60,
              width: sclW(context) * 80,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(width: 5, color: Colors.white),
                  borderRadius: BorderRadius.circular(5)),
            ),
          ), */
          const CountDown(),
        ]);
      case 3:
        return const EfectoPage();
      case 4:
        return const SettingsVideo();

      default:
        return Center(
            child: Text('Cargando...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: sclH(context) * 4)));
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
          body: /*Expanded(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),*/

              Center(child: SelectActionShow(_selectedIndex)),
          bottomNavigationBar: Container(
            //height: 120,
            color: AppColors.vulcan,
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: Colors.transparent,
              //  Color.fromARGB(250, 20, 18, 32),

              selectedFontSize: sclH(context) * 2,
              selectedItemColor: AppColors.royalBlue,
              selectedIconTheme: IconThemeData(size: sclH(context) * 6),
              unselectedFontSize: sclH(context) * 1.5,
              unselectedItemColor: Colors.white,
              unselectedIconTheme: IconThemeData(size: sclH(context) * 3),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(currentIcon),
                  label: currentLabel,
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.filter_b_and_w),
                  label: 'Filtro',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.camera,
                    // _getCameraIcon(_cameras[_cameraIndex].lensDirection),
                  ),
                  label: 'Camara',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.camera_enhance_sharp),
                  label: 'Efecto',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Ajustes',
                ),
              ],

              onTap: (value) {
                switch (value) {
                  case 0:
                    _onSwitchCamera();
                    break;

                  case 1:
                    //_recordVideo();
                    break;
                  case 2:
                    //s
                    // _isRecording ? null : _onPlay,
                    break;
                  default:
                }

                _selectedIndex = value;
                //tomar valores
                _selectedIndex == 0
                    ? isCamSelected = true
                    : isCamSelected = false;

                setState(() {});
              },
            ),
          ),
        ));
  }
}
