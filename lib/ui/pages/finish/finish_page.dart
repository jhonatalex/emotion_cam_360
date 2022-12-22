import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

TextEditingController controller = TextEditingController();

class FinishPage extends StatefulWidget {
  const FinishPage({Key? key}) : super(key: key);

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.offNamed(RouteNames.camera),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.home,
                color: AppColors.royalBlue,
                size: 40,
              ),
              onPressed: () => Get.offNamed(RouteNames.home),
            ),
            const SizedBox(
              width: 10,
            )
          ]),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        color: AppColors.vulcan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Escanea el QR \n para descargar tu video",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            QrImage(
              data: "Codigo de Usuario",
              backgroundColor: Colors.white,
              version: QrVersions.auto,
              size: sclW(context) * 40,
            ),
          ],
        ),
      ),
    );
  }
}
