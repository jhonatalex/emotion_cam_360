import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import '../../repositories/abstractas/responsive.dart';
import '../pages/camera/camera_controller.dart';
import '../routes/route_names.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

//el ejemplo de arriba ess para giarnos por eso hago otra clase aqui
//para utilizarla mientras el widget camera
//dice que no funciona en emuladores
int endTime = 0;

class CameraApp2 extends StatefulWidget {
  const CameraApp2({super.key});

  @override
  State<CameraApp2> createState() => _CameraApp2State();
}

class _CameraApp2State extends State<CameraApp2> {
  bool _isFirst = true;
  get scanner => null;

  late List<CameraDescription> _cameras; // Lista de cámaras disponibles
  late CameraController _controller; // Controlador de la cámara
  late int _cameraIndex; // Índice de cámara actual
  bool _isRecording = false; // Bandera indicadora de grabación en proceso
  late String _filePath; // Direc

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

  // Inicializar la cámara
  _initCamera(CameraDescription camera) async {
    // Si el controlador está en uso,
    // realizar un dispose para detenerlo antes de continuar
    if (_controller != null) await _controller.dispose();
    // Indicar al controlador la nueva cámara a utilizar
    _controller = CameraController(camera, ResolutionPreset.medium);
    // Agregar un Listener para refrescar la pantalla en cada cambio
    _controller.addListener(() => this.setState(() {}));
    // Inicializar el controlador
    _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    //DEPENDENCIAS y VARIALBLES
    //final cameraController = ;
    //final isSaving = cameraController.isSaving.value;

    String videoPath;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CountdownTimer(
          textStyle: TextStyle(fontSize: sclH(context) * 3),
          endTime: endTime,
          onEnd: () async {
            if (_isFirst == false) {
              Get.offNamed(RouteNames.videoScreen);

              /*


              final ImagePicker _picker = ImagePicker();
              final pickedFile = await ImagePicker().getVideo(
                  source: ImageSource.camera,
                  maxDuration: Duration(seconds: 5));
              videoPath = pickedFile!.path;
              //_pickedFile.readAsBytes().then((value) => null);

              final Uint8List bytesVideo = await pickedFile.readAsBytes();
              //final String barcode = await scanner.scanBytes(bytes);
              print("ENTRO");
              print(bytesVideo);

              if (pickedFile != null) {
                print("ENTR CONDICIONALO");

                //Get.find<CamaraVideoController>().setVideo(bytesVideo);
              }

              Random random = Random();
              int randomNumber = random.nextInt(100);

              Get.find<CamaraVideoController>()
                  .saveVideo('Emotion360-$randomNumber', videoPath, bytesVideo);

              // isSaving ? null : () => CamaraVideoController.openCamaraVideo();

              */

              ///Get.offNamed(RouteNames.finish);
            }
          },
          widgetBuilder: (_, time) {
            if (time == null) {
              _isFirst = false;
              return Container();
            }
            return Column(
              children: [
                Text(
                  'Preparate...',
                  style: TextStyle(fontSize: sclH(context) * 4),
                ),
                Text(
                  '${time.sec}',
                  style: TextStyle(fontSize: sclH(context) * 20),
                ),
                Text(
                  'La aventura está por comenzar...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: sclH(context) * 4),
                ),
              ],
            );
          },
        ),
        SizedBox(
          height: sclH(context) * 3,
        ),
        TextButton(
          onPressed: () async {
            endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
            setState(() {});
          },
          child: Image.asset(
            "assets/img/buttonplay.png",
            width: sclH(context) * 25,
            height: sclH(context) * 15,
          ),
        ),
      ],
    );
  }
}
