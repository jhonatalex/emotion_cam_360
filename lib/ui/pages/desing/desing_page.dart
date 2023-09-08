import 'dart:io';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/ui/pages/desing/desing_controller.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DesingPage extends StatefulWidget {
  const DesingPage({super.key});

  @override
  State<DesingPage> createState() => _DesingPageState();
}

class _DesingPageState extends State<DesingPage> {
  final DesingController desingController = Get.put(DesingController());

  String logoPath = "";
  recursos(context) {
    final eventProvider =
        Provider.of<EventoActualPreferencesProvider>(context, listen: false);
    eventProvider.eventPrefrerences == null
        ? logoPath = "assets/img/logo-emotion.png"
        : logoPath = eventProvider.eventPrefrerences.overlay;
  }

  @override
  Widget build(BuildContext context) {
    recursos(context);
    return Obx((() {
      return Stack(
        children: [
          //*********MARCOS************** */
          Image.asset(
            "assets/themes/${desingController.marcos[desingController.currentMarco.value]}",
          ),
          //*********LOGO *****************/
          if (desingController.isWithLogo.value)
            Positioned(
              //top: desingController.logoTop.value.toDouble(),
              //left: sclW(context) * 5 + desingController.logoLeft.value,
              bottom: 5,
              right: 5,
              child: logoPath.contains("assets")
                  ? Image.asset(
                      "assets/img/logo-emotion.png",
                      width: sclW(context) * 14,
                      height: sclW(context) * 14,
                    )
                  : Image.file(
                      File(logoPath),
                      width: 60, //sclW(context) * 30,
                      height: 60, //sclW(context) * 30,
                    ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: () {
                  if (desingController.currentMarco.value <
                      desingController.marcos.length - 1) {
                    desingController.currentMarco.value++;
                  } else {
                    desingController.currentMarco.value = 0;
                  }
                },
                icon: const Icon(
                  Icons.change_circle_outlined,
                  color: AppColors.violet,
                  size: 22,
                ),
                label: const Text(
                  "Marco",
                  style: TextStyle(color: AppColors.violet, fontSize: 22),
                ),
              ),
            ],
          ),
        ],
      );
    }));
  }
}
