import 'dart:async';

import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

TextEditingController controller = TextEditingController();

double _sise = 1;

class FinishQrPage extends StatefulWidget {
  const FinishQrPage({Key? key}) : super(key: key);

  @override
  State<FinishQrPage> createState() => _FinishQrPageState();
}

bool isDelay = false;

class _FinishQrPageState extends State<FinishQrPage> {
  String urlVideo = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: sclH(context) * 7,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.home),
            iconSize: sclH(context) * 3,
            onPressed: () => Get.offNamed(RouteNames.home),
          )),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        color: AppColors.vulcan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Escanea el QR \n para descargar tu video",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: sclH(context) * 3),
            ),
            SizedBox(
              height: sclH(context) * 3,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 2000),
              curve: Curves.easeInToLinear,
              child: QrImage(
                data: urlVideo,
                backgroundColor: Colors.white,
                version: QrVersions.auto,
                size: sclH(context) * 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _changeValue() {
  _sise = 40;
}
