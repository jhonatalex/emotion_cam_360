import 'package:emotion_cam_360/ui/widgets/Background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repositories/abstractas/appcolors.dart';
import '../../../repositories/abstractas/responsive.dart';
import '../../routes/route_names.dart';
import '../../widgets/drawer.dart';

int current = 0;

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

var bgColorActive =
    MaterialStateProperty.all(AppColors.royalBlue.withOpacity(0.5));

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    final imgList = ["assets/img/stylo1.jpg", "assets/img/stylo2.jpg"];

    return Scaffold(
      backgroundColor: AppColors.vulcan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: sclH(context) * 7,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: sclH(context) * 3,
          onPressed: (() => Get.offNamed(RouteNames.home)),
        ),
      ),
      body: Stack(
        children: [
          BackgroundBlur(
            imgList: imgList,
            current: current,
            bgHeight: sclH(context) * 90,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: bgColor1(),
                    ),
                    onPressed: () {
                      current = 0;
                      setState(() {});
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          imgList[0],
                          height: sclH(context) * 25,
                          width: sclH(context) * 17.5,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: sclH(context) * 2,
                        ),
                        Text(
                          "Transicion B",
                          style: TextStyle(fontSize: sclH(context) * 2),
                        ),
                        SizedBox(
                          height: sclH(context) * 2,
                        )
                      ],
                    ),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      //backgroundColor: MaterialStatePropertyAll<Color>(AppColors.violet),
                      backgroundColor: bgColor2(),
                    ),
                    onPressed: () {
                      current = 1;
                      setState(() {});
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          imgList[1],
                          height: sclH(context) * 25,
                          width: sclH(context) * 17.5,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: sclH(context) * 2,
                        ),
                        Text(
                          "Transicion B",
                          style: TextStyle(
                              color: Colors.white, fontSize: sclH(context) * 2),
                        ),
                        SizedBox(
                          height: sclH(context) * 2,
                        )
                      ],
                    ),
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.offNamed(RouteNames.camera);
                  },
                  child: Text(
                    'PAGAR',
                    style: TextStyle(
                      fontSize: sclH(context) * 3,
                    ),
                  )),
            ],
          ),
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}

bgColor1() {
  if (current == 0) {
    return bgColorActive;
  } else {}
}

bgColor2() {
  if (current == 1) {
    return bgColorActive;
  } else {}
}
