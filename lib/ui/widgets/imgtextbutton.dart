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
      child: TextButton(
        style: ElevatedButton.styleFrom(
            // foregroundColor: Colors.white,
            primary: Colors.transparent,
            elevation: 0 // foreground
            ),
        onPressed: () {
          Get.offNamed(RouteNames.videoPage);
        },
        child: Text(
          "INICIAR EXPERIENCIA 360°",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: sclH(context) * 5,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
