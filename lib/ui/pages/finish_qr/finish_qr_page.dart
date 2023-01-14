import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class FinishQrPage extends StatelessWidget {
  FinishQrPage({super.key});
  bool isDelay = false;

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
              onPressed: () {
                Get.offNamed(RouteNames.home);
              })),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BackgroundGradient(context),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.easeInToLinear,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: QrImage(
                    data: urlVideo,
                    backgroundColor: Colors.white,
                    version: QrVersions.auto,
                    size: sclH(context) * 40,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  spacing: 20,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.facebook),
                      label: Text("Facebook"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.pink,
                      ),
                      label: Text("Instagram"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.whatsapp_rounded,
                        color: Colors.green,
                      ),
                      label: Text("Whatsapp"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
