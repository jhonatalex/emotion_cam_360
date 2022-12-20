import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

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
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CountdownTimer(
          textStyle: const TextStyle(fontSize: 30),
          endTime: endTime,
          widgetBuilder: (_, time) {
            if (time == null) {
              return const Text(
                '',
                style: TextStyle(fontSize: 30),
              );
            }
            return Column(
              children: [
                const Text(
                  'Preparate...',
                  style: TextStyle(fontSize: 40),
                ),
                Text(
                  '${time.sec}',
                  style: const TextStyle(fontSize: 200),
                ),
                const Text(
                  'La aventura está por comenzar...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton.icon(
          onPressed: () {
            endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
            setState(() {});
          },
          icon: const Icon(
            Icons.play_arrow_outlined,
            size: 40,
          ),
          label: const Text(
            "Iniciar",
            style: TextStyle(fontSize: 50),
          ),
        ),
      ],
    ));
  }
}
