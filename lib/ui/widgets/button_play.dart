import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../repositories/abstractas/responsive.dart';
import '../routes/route_names.dart';

//el ejemplo de arriba ess para giarnos por eso hago otra clase aqui
//para utilizarla mientras el widget camera
//dice que no funciona en emuladores
int endTime = 5;

class ButtonPlay extends StatefulWidget {
  const ButtonPlay({super.key});

  @override
  State<ButtonPlay> createState() => _ButtonPlayState();
}

class _ButtonPlayState extends State<ButtonPlay> {
  bool _isFirst = true;
  double _opacity = 1.0;
  double _width = 15;

  @override
  Widget build(BuildContext context) {
    //DEPENDENCIAS y VARIALBLES
    //final cameraController = ;
    //final isSaving = cameraController.isSaving.value;

    String videoPath;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              AnimatedOpacity(
                opacity: _opacity,
                curve: Curves.easeInToLinear,
                duration: Duration(milliseconds: 700),
                onEnd: () => Get.offNamed(RouteNames.videoRecording),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_opacity == 1) {
                          setState(() {
                            _changeValue();
                          });
                        }
                        ;
                      },
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.easeInSine,
                          width: sclH(context) * _width,
                          height: sclH(context) * _width * 2 / 3,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: const DecorationImage(
                                image: AssetImage(
                                  "assets/img/buttonplay.png",
                                ),
                                fit: BoxFit.cover),
                          )),
                    ),
                    Text(
                      "INICIAR",
                      style: TextStyle(
                        fontSize: sclH(context) * 3,
                      ),
                    ),
                  ],
                ),
              ),

              /* 
              AnimatedOpacity(
                opacity: 1 - _opacity,
                curve: Curves.easeInToLinear,
                duration: Duration(milliseconds: 500),
                child: ButtonPlayTimer(
                  textStyle: TextStyle(fontSize: sclH(context) * 3),
                  endTime: endTime,
                  onEnd: () async {
                    if (_isFirst == false) {
                      Get.offNamed(RouteNames.videoRecording);
                    }
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
                    //}
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
              ),
              AnimatedOpacity(
                opacity: _opacity,
                curve: Curves.easeInToLinear,
                duration: Duration(milliseconds: 700),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_opacity == 1) {
                          endTime =
                              DateTime.now().millisecondsSinceEpoch + 1000 * 5;

                          setState(() {
                            _changeValue();
                          });
                        }
                        ;
                      },
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.easeInSine,
                          width: sclH(context) * _width,
                          height: sclH(context) * _width * 2 / 3,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: const DecorationImage(
                                image: AssetImage(
                                  "assets/img/buttonplay.png",
                                ),
                                fit: BoxFit.cover),
                          )),
                    ),
                    Text(
                      "INICIAR",
                      style: TextStyle(
                        fontSize: sclH(context) * 3,
                      ),
                    ),
                  ],
                ),
              ), */
            ],
          ),
        ],
      ),
    );
  }

  void _changeValue() {
    _opacity = _opacity == 0 ? 1.0 : 0.0;
    _width = 100;
  }
}
