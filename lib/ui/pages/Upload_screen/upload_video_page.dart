import 'dart:async';

import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({Key? key}) : super(key: key);

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  String _txt = 'Cargando Video a la nube....';
  @override
  void initState() {
//TODO
// CARGAR EL VIDEO A FIRSETORE

    super.initState();
  }

//LUEGO DE LA CARGA ENVIAR A LA PANTALLA DE QR CON LA URL DE DESCRAGA

  @override
  Widget build(BuildContext context) {
    //final UploadVideoController controller = Get.find<UploadVideoController>();

    void cambiarTexto() {
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          _txt = " Su video ha sido cargado completamente.\n\n Redirigiendo...";
        });
      });
      Timer(Duration(seconds: 2), () {
        Get.offNamed(RouteNames.finishQr);
      });
    }

    return Scaffold(
      backgroundColor: AppColors.vulcan,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                tileMode: TileMode.clamp,
                stops: [
              0.0,
              1
            ],
                colors: [
              AppColors.violet,
              AppColors.royalBlue,
            ])),
        child: Expanded(
          child: Column(
            children: [
              Center(
                  child: Padding(
                      padding: EdgeInsets.all(sclW(context) * 25),
                      child: SimpleCircularProgressBar(
                          progressColors: const [
                            Colors.cyan,
                            Color.fromARGB(255, 64, 251, 104)
                          ],
                          mergeMode: true,
                          onGetText: (double value) {
                            if (value == 100) {
                              cambiarTexto();
                            }
                            return Text(
                              '${value.toInt()} %',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }))),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                child: Text(
                  _txt,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
