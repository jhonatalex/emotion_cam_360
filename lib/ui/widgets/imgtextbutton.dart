import 'package:emotion_cam_360/ui/widgets/responsive.dart';
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
            image: AssetImage("assets/img/background.jpg"), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(sclH(context) * 3),
            primary: Colors.transparent,
            elevation: 0),
        onPressed: () {
          Get.toNamed(RouteNames.videoPage);
        },
        child: Text(
          "INICIAR EXPERIENCIA 360°",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: sclH(context) * 2.5,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
