import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/route_names.dart';

class ImgTextButton extends StatelessWidget {
  const ImgTextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage("assets/img/background.png"), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 0.5,
          color: Colors.white,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(sclH(context) * 3),
            backgroundColor: Colors.transparent,
            elevation: 0),
        onPressed: () {
          Get.offNamed(RouteNames.camera);
        },
        child: Text(
          "INICIAR EXPERIENCIA 360°",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: sclH(context) * 3,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
