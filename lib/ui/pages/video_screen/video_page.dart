import 'package:camera/camera.dart';
import 'package:emotion_cam_360/ui/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repositories/abstractas/appcolors.dart';
import '../../../repositories/abstractas/responsive.dart';
import '../../routes/route_names.dart';
import '../../widgets/camera.dart';
import '../../widgets/show_video_page.dart';
import 'video_controller.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late List<CameraDescription> _cameras; // Lista de cámaras disponibles
  CameraController? _controller; // Controlador de la cámara
  late int _cameraIndex; // Índice de cámara actual

  bool _isRecording = false; // Bandera indicadora de grabación en proceso

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
        _cameraIndex = 0;
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
  }

  // Crear el Widget con la visualización del cámara
  Widget _buildCamera() {
    // Si el controlador es nulo o no está inicializado aún,
    // desplegar un mensaje al usuario y evitar mostrar una cámara sin inicializar
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: Text('Loading...'));
    }

    // Utilizar un Widget de tipo AspectRatio para desplegar el alto y ancho correcto
    return AspectRatio(
      // Solicitar la relación alto/ancho al controlador
      aspectRatio: 16 / 22,
      // Mostrar el contenido del controlador mediante el Widget CameraPreview
      child: CameraPreview(_controller!),
    );
  }

  // Retornar el ícono de la cámara
  IconData _getCameraIcon(CameraLensDirection lensDirection) {
    return lensDirection == CameraLensDirection.back
        ? Icons.camera_rear
        : Icons.camera_front;
  }

  // Cambia la cámara actual
  void _onSwitchCamera() {
    if (_cameras.length < 2) return;
    _cameraIndex = (_cameraIndex + 1) % 2;
    _initCamera(_cameras[_cameraIndex]);
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

  int _selectedIndex = 1;

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
              onPressed: (() => Get.offNamed(RouteNames.menu)),
            ),
          ),
          backgroundColor: AppColors.vulcan,
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: Column(
            children: [
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Center(child: _buildCamera())),
              )
            ],
          ),
          bottomNavigationBar: Container(
            height: 161,
            color: AppColors.vulcan,
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: Colors.transparent,
              //  Color.fromARGB(250, 20, 18, 32),

              selectedFontSize: sclH(context) * 3,
              selectedItemColor: AppColors.royalBlue,
              selectedIconTheme: IconThemeData(size: sclH(context) * 6),
              unselectedFontSize: sclH(context) * 2,
              unselectedItemColor: Colors.white,
              unselectedIconTheme: IconThemeData(size: sclH(context) * 3),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                      _getCameraIcon(_cameras[_cameraIndex].lensDirection)),
                  label: 'Camara',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                      _isRecording ? Icons.stop : Icons.radio_button_checked),
                  label: _isRecording ? "Parar" : "Grabar",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.playlist_play_rounded),
                  label: 'Ver',
                ),
              ],
              onTap: (value) {
                switch (value) {
                  case 0:
                    _onSwitchCamera();
                    break;

                  case 1:
                    _recordVideo();

                    break;
                  case 2:
                    // _isRecording ? null : _onPlay,
                    break;
                  default:
                }

                _selectedIndex = value;

                setState(() {});
              },
            ),
          ),
        ));
  }
}
