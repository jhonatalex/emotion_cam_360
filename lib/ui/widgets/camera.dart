import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

import '../../repositories/abstractas/responsive.dart';
import '../routes/route_names.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(const CameraApp());
}

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: CameraPreview(controller),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CountdownTimer(
          textStyle: TextStyle(fontSize: sclH(context) * 3),
          endTime: endTime,
          onEnd: () {
            if (_isFirst == false) {
              Get.offNamed(RouteNames.finish);
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
        ElevatedButton.icon(
          onPressed: () {
            endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
            setState(() {});
          },
          icon: Icon(
            Icons.play_arrow_outlined,
            size: sclH(context) * 4,
          ),
          label: Text(
            "Iniciar",
            style: TextStyle(fontSize: sclH(context) * 5),
          ),
        ),
      ],
    ));
  }
}
