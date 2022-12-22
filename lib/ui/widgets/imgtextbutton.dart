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
    return Padding(
      padding: EdgeInsets.all(sclH(context) * 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            // foregroundColor: Colors.white,
            primary: Colors.transparent,
            elevation: 0 // foreground
            ),
        onPressed: () {
          Get.offNamed(RouteNames.menu);
        },
        child: Column(
          children: [
            Center(
                child: Image.asset(
              "assets/img/logo-emotion.png",
              height: sclH(context) * 16,
            )),
            Text(
              "INICIAR EXPERIENCIA 360°",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: sclH(context) * 2.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
