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
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            tileMode: TileMode.clamp,
            stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1],
            colors: [
              Color(0xff31B6F2),
              Color(0xff7B0786),
              Color(0xffC50524),
              Color(0xffEB0374),
              Color(0xff520177),
              Color(0xff7996EE),
            ],
          )),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(sclH(context) * 3),
            backgroundColor: Colors.transparent,
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
              color: Colors.white,
              shadows: const [
                Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 2)
              ]),
        ),
      ),
    );
  }
}
