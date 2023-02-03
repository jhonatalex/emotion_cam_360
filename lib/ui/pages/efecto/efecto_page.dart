import 'package:emotion_cam_360/ui/widgets/Background.dart';
import 'package:flutter/material.dart';

import '../../widgets/appcolors.dart';
import '../../widgets/responsive.dart';
import '../../widgets/drawer.dart';

int current = 0;

class EfectoPage extends StatefulWidget {
  const EfectoPage({super.key});

  @override
  State<EfectoPage> createState() => _EfectoPageState();
}

var bgColorActive =
    MaterialStateProperty.all(AppColors.royalBlue.withOpacity(0.5));

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
      body: Stack(
        children: [
          BackgroundBlur(
            imgList: imgList,
            current: current,
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
                      Text(
                        "Transicion A",
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
                      Text(
                        "Transicion B",
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
                    current = 2;
                    setState(() {});
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
                        "Transicion C",
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
                    current = 3;
                    setState(() {});
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
                        "Transicion D",
                        style: TextStyle(
                            color: Colors.white, fontSize: sclH(context) * 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
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

bgColor3() {
  if (current == 2) {
    return bgColorActive;
  } else {}
}

bgColor4() {
  if (current == 3) {
    return bgColorActive;
  } else {}
}
