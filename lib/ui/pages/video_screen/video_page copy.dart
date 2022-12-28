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
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();

    // Verificar la lista de cámaras disponibles al iniciar el Widget
    availableCameras().then((cameras) async {
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
  }

  Widget _buildCamera() {
    // desplegar un mensaje al usuario y evitar mostrar una cámara sin inicializar
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: Text('Loading...'));
    }
    // Utilizar un Widget de tipo AspectRatio para desplegar el alto y ancho correcto
    return Center(
      //  margin: const EdgeInsets.only(top: 50.0),
      //child: AspectRatio(
      //   aspectRatio: 16 / 22,
      child: CameraPreview(_controller!),
      // ),
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
    print("PARO DE GRABAR");
    final file = await _controller?.stopVideoRecording();
    setState(() => _isRecording = false);
    final route = MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => ShowVideoPage(filePath: file!.path),
    );
    Navigator.push(context, route);
  }

  _recordVideo() async {
    print("ENTRO GRABAR");
    await _controller?.prepareForVideoRecording();
    await _controller?.startVideoRecording();

    setState(() => _isRecording = true);
  }

  Widget SelectActionShow(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const EfectoPage();

      case 1:
        return Stack(children: [
          _buildCamera(),
          Container(
            color: AppColors.vulcan.withOpacity(0.5),
          ),
          const CountDown(),
        ]);
      case 2:
        return const SettingsVideo();
      case 3:
        return _buildCamera();
      case 4:
        return const Text(
          'Filtro',
          style: TextStyle(fontSize: 50),
        );

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

              selectedFontSize: sclH(context) * 3,
              selectedItemColor: AppColors.royalBlue,
              selectedIconTheme: IconThemeData(size: sclH(context) * 6),
              unselectedFontSize: sclH(context) * 2,
              unselectedItemColor: Colors.white,
              unselectedIconTheme: IconThemeData(size: sclH(context) * 3),
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.camera_enhance_sharp),
                  label: 'Efecto',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                      _getCameraIcon(_cameras[_cameraIndex].lensDirection)),
                  label: 'Camara',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Ajustes',
                ), /* 
                const BottomNavigationBarItem(
                  icon: Icon(Icons.filter_b_and_w),
                  label: 'Filtro',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                      _isRecording ? Icons.stop : Icons.radio_button_checked),
                  label: _isRecording ? "Parar" : "Grabar",
                ), */
              ],

              onTap: (value) {
                switch (value) {
                  case 0:
                    break;

                  case 1:
                    //_recordVideo();

                    _onSwitchCamera();
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
