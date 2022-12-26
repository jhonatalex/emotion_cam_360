import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

TextEditingController controller = TextEditingController();

class FinishQrPage extends StatefulWidget {
  const FinishQrPage({Key? key}) : super(key: key);

  @override
  State<FinishQrPage> createState() => _FinishQrPageState();
}

class _FinishQrPageState extends State<FinishQrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: sclH(context) * 7,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: sclH(context) * 3,
            onPressed: () => Get.offNamed(RouteNames.camera),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: AppColors.royalBlue,
                size: sclH(context) * 3,
              ),
              onPressed: () => Get.offNamed(RouteNames.home),
            ),
            SizedBox(
              width: sclH(context) * 1,
            )
          ]),
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
            QrImage(
              data: "Codigo de Usuario",
              backgroundColor: Colors.white,
              version: QrVersions.auto,
              size: sclH(context) * 40,
            ),
          ],
        ),
      ),
    );
  }
}
