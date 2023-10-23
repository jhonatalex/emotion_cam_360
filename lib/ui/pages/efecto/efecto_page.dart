import 'package:emotion_cam_360/ui/pages/settings/settings-controller.dart';
import 'package:emotion_cam_360/ui/widgets/Background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/appcolors.dart';
import '../../widgets/responsive.dart';
import '../../widgets/drawer.dart';

class EfectoPage extends StatefulWidget {
  const EfectoPage({super.key});

  @override
  State<EfectoPage> createState() => _EfectoPageState();
}

var bgColorActive =
    MaterialStateProperty.all(AppColors.royalBlue.withOpacity(0.5));

final SettingsController settingsController = Get.put(SettingsController());

class _EfectoPageState extends State<EfectoPage> {
  @override
  Widget build(BuildContext context) {
    final imgList = [
      "assets/img/stylo1.jpg",
      "assets/img/stylo2.jpg",
      "assets/img/stylo3.jpg",
      "assets/img/stylo4.jpg",
    ];
    return Scaffold(
      backgroundColor: AppColors.vulcan,
      extendBodyBehindAppBar: true,
      body: Obx(() {
        return Stack(
          children: [
            BackgroundBlur(
              imgList: imgList,
              current: settingsController.fondoVideo.value,
              bgHeight: sclH(context) * 90,
            ),
            Center(
                child: Wrap(
              spacing: 20,
              runSpacing: 20,
              runAlignment: WrapAlignment.spaceAround,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: bgColor1(),
                  ),
                  onPressed: () {
                    settingsController.fondoVideo.value = 0;
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        imgList[0],
                        height: sclH(context) * 25,
                        width: sclH(context) * 17.5,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "Espiral",
                        style: TextStyle(fontSize: sclH(context) * 2),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    //backgroundColor: MaterialStatePropertyAll<Color>(AppColors.violet),
                    backgroundColor: bgColor2(),
                  ),
                  onPressed: () {
                    settingsController.fondoVideo.value = 1;
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        imgList[1],
                        height: sclH(context) * 25,
                        width: sclH(context) * 17.5,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "Letras",
                        style: TextStyle(
                            color: Colors.white, fontSize: sclH(context) * 2),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: bgColor3(),
                  ),
                  onPressed: () {
                    settingsController.fondoVideo.value = 2;
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        imgList[2],
                        height: sclH(context) * 25,
                        width: sclH(context) * 17.5,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "Chispas",
                        style: TextStyle(fontSize: sclH(context) * 2),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    //backgroundColor: MaterialStatePropertyAll<Color>(AppColors.violet),
                    backgroundColor: bgColor4(),
                  ),
                  onPressed: () {
                    settingsController.fondoVideo.value = 3;
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        imgList[3],
                        height: sclH(context) * 25,
                        width: sclH(context) * 17.5,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        "Neon",
                        style: TextStyle(
                            color: Colors.white, fontSize: sclH(context) * 2),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ],
        );
      }),
      drawer: const MyDrawer(),
    );
  }

  bgColor1() {
    if (settingsController.fondoVideo.value == 0) {
      return bgColorActive;
    } else {}
  }

  bgColor2() {
    if (settingsController.fondoVideo.value == 1) {
      return bgColorActive;
    } else {}
  }

  bgColor3() {
    if (settingsController.fondoVideo.value == 2) {
      return bgColorActive;
    } else {}
  }

  bgColor4() {
    if (settingsController.fondoVideo.value == 3) {
      return bgColorActive;
    } else {}
  }
}
