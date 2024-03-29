import 'dart:async';
import 'package:camera/camera.dart';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/ui/pages/desing/desing_page.dart';
import 'package:emotion_cam_360/ui/pages/efecto/efecto_page.dart';
import 'package:emotion_cam_360/ui/pages/settings/settings-controller.dart';
import 'package:emotion_cam_360/ui/widgets/messenger_snackbar.dart';
import 'package:emotion_cam_360/ui/pages/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../widgets/appcolors.dart';
import '../../widgets/responsive.dart';
import '../../routes/route_names.dart';
import '../../widgets/dropdown_events.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  //Variables
  late List<CameraDescription> _cameras; // Lista de cámaras disponibles
  CameraController? _controller; // Controlador de la cámara

  // bool _isRecording = false; // Bandera indicadora de grabación en proceso

  // bool _isFirst = true;
  int _selectedIndex = 2;
  IconData currentIcon = Icons.camera_front;
  String currentLabel = "Frontal";
  bool isCamSelected = true;
  late int _cameraIndex; // Índice de cámara actual
  double _opacity = 1.0;
  double _width = 15;
  int endTime = 5;

  //late var listEvents;

  final _evenController = Get.put(EventController());
  final SettingsController settingsController = Get.put(SettingsController());

  @override
  void initState() {
    super.initState();

    // Verificar la lista de cámaras disponibles al iniciar el Widget
    availableCameras().then((cameras) {
      // Guardar la lista de cámaras
      _cameras = cameras;
      // Inicializar la cámara solo si la lista de cámaras tiene cámaras disponibles
      if (_cameras.isNotEmpty) {
        // Inicializar el índice de cámara actual en 0 para obtener la primera
        // si tiene frontal sería la index=1
        _cameraIndex = settingsController.cameraIndex.value;
        // Inicializar la cámara pasando el CameraDescription de la cámara seleccionada
        _initCamera(_cameras[_cameraIndex]);
      }
    });

    ///quitar manera vieja de trasladar los datos
    //getMyEventClass('Santiago_fecha_8-1-2023');
    //_evenController.getMyEventController('Santiago_fecha_8-1-2023');
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  _initCamera(CameraDescription camera) async {
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

    // Indicar al controlador la nueva cámara a utilizar
    _controller = CameraController(camera, ResolutionPreset.high);
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
    return CameraPreview(_controller!);
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
    settingsController.cameraIndex.value = _cameraIndex;
  }

  // ignore: non_constant_identifier_names

  Widget selectActionShow(
      int selectedIndex, EventoActualPreferencesProvider eventProvider) {
    switch (selectedIndex) {
      case 0:
        return _buildCamera();

      case 1:
        return Container(
          height: sclH(context) * 80,
          width: sclH(context) * 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildCamera(),
              const DesingPage(),
            ],
          ),
        );
      case 2:
        return Stack(alignment: AlignmentDirectional.center, children: [
          _buildCamera(),
          _butomPlayBuilding(eventProvider),
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

  void _changeValue() {
    _opacity = _opacity == 0 ? 1.0 : 0.0;
    _width = 100;
  }

  Widget _butomPlayBuilding(EventoActualPreferencesProvider eventProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              AnimatedOpacity(
                opacity: _opacity,
                curve: Curves.easeInToLinear,
                duration: const Duration(milliseconds: 700),
                onEnd: () => Get.toNamed(RouteNames.videoRecording),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (eventProvider.seleccionarPrefrerences) {
                          if (_opacity == 1) {
                            setState(() {
                              _changeValue();
                            });
                          }
                        } else {
                          MessengerSnackBar(
                              context, "Debe crear o seleccionar un evento");
                        }
                      },
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInSine,
                          width: sclH(context) * _width,
                          height: sclH(context) * _width * 2 / 3,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                tileMode: TileMode.mirror,
                                stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1],
                                colors: [
                                  Color(0xff31B6F2),
                                  Color(0xff7B0786),
                                  Color(0xffC50524),
                                  Color(0xffEB0374),
                                  Color(0xff520177),
                                  Color(0xff7996EE),
                                ],
                              )
                              /* image: const DecorationImage(
                                image: AssetImage(
                                  "assets/img/buttonplay.png",
                                ),
                                fit: BoxFit.cover), */
                              ),
                          child: Icon(Icons.play_arrow,
                              size: sclW(context) * 15,
                              shadows: const [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                    blurRadius: 2)
                              ])),
                    ),
                    Text(
                      "INICIAR",
                      style: TextStyle(
                          fontSize: sclH(context) * 3,
                          shadows: const [
                            Shadow(
                                color: Colors.black,
                                offset: Offset(1, 1),
                                blurRadius: 2)
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //var isLoading = _evenController.isLoading.value;

      var eventBd = _evenController.eventoBd.value;

      final eventProvider =
          Provider.of<EventoActualPreferencesProvider>(context);
      //eventProvider.saveEventPrefrerence(eventoSelected);
      print(chalk.yellow.bold(eventBd));

      return DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: sclH(context) * 7,
              backgroundColor: Colors.transparent,
              //elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                iconSize: sclH(context) * 3,
                onPressed: (() => Get.offNamed(RouteNames.home)),
              ),
              centerTitle: true,
              title: DropdownEventos(eventBd),
            ),
            backgroundColor: AppColors.vulcan,
            //extendBodyBehindAppBar: true,
            extendBody: true,
            body: selectActionShow(_selectedIndex, eventProvider),
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
                    label: 'Diseño',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.camera,
                      // _getCameraIcon(_cameras[_cameraIndex].lensDirection),
                    ),
                    label: 'Iniciar',
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
    });
  }
}
