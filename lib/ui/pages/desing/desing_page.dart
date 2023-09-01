import 'dart:io';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/ui/pages/desing/desing_controller.dart';
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
      return SizedBox(
        width: sclW(context) * 100,
        height: sclH(context) * 80,
        //margin: EdgeInsets.only(bottom: sclH(context) * 10),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            //*********MARCOS************** */
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/themes/${desingController.marcos[desingController.currentMarco.value]}",
                width: sclW(context) * 90,
                height: sclH(context) * 80,
              ),
            ),

            //*********TEXTO *****************/
            /* if (desingController.isWithText.value)
              Positioned(
                top: sclH(context) * 50 - 200,
                left: sclW(context) * 50 - 100, // textleft[current],
                child: SizedBox(
                  width: 200,
                  child: TextFormField(
                    decoration:
                        const InputDecoration(hintText: "Ingresar texto"),
                    //style: TextStyle(backgroundColor: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ), */
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
                /* TextButton.icon(
                  onPressed: () {
                    desingController.isWithText.value =
                        !desingController.isWithText.value;
                  }, 
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Texto",
                    style: TextStyle(color: Colors.white),
                  ),
                ),*/
                /* TextButton.icon(
                  onPressed: () => desingController.logoPositionChange(context),
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Logo",
                    style: TextStyle(color: Colors.white),
                  ),
                ), */
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
                    Icons.add_circle,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Marco",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }));
  }
}