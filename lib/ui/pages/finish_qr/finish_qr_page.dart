// ignore_for_file: must_be_immutable
import 'package:emotion_cam_360/ui/pages/finish_qr/finish_controller.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/background_gradient.dart';
import 'package:emotion_cam_360/ui/widgets/share_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class FinishQrPage extends StatelessWidget {
  FinishQrPage({super.key});
  bool isDelay = false;

  final _finishQrController = Get.find<FinishQrController>();
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
              Get.offAllNamed(RouteNames.home);
            }),
        actions: [
          Sharebuttons(_finishQrController.shortenedUrl.value ?? urlVideo, "")
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BackgroundGradient(context),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

              ElevatedButton.icon(
                    onPressed: () {
                      Get.offAllNamed(RouteNames.videoPage);
                    },
                    icon: const Icon(Icons.play_arrow_outlined),
                    label: Text("Grabar Nuevo Video"),
                    style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll<double>(
                       1,
                      ),
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        AppColors.violet,
                      ),
                    ),
                  ),


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
                    child: Obx(() =>
                        _finishQrController.shortenedUrl.value == null
                            ? const CircularProgressIndicator()
                            : QrImageView(
                                //genera un salto
                                data: _finishQrController.shortenedUrl.value
                                    .toString(),
                                backgroundColor: Colors.white,
                                version: QrVersions.auto,
                                size: sclH(context) * 40,
                                eyeStyle: const QrEyeStyle(
                                    eyeShape: QrEyeShape.square,
                                    color: Colors.black),
                                dataModuleStyle: const QrDataModuleStyle(
                                    dataModuleShape: QrDataModuleShape.square,
                                    color: Colors.black)))),
                const SizedBox(
                  height: 20,
                ),
                Sharebuttons(_finishQrController.shortenedUrl.value ?? urlVideo,
                    "Compartir"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
