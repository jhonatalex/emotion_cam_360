import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:emotion_cam_360/ui/pages/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.find<SplashController>();
    return Scaffold(
      backgroundColor: AppColors.vulcan,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                tileMode: TileMode.clamp,
                stops: [
              0.0,
              1
            ],
                colors: [
              AppColors.violet,
              AppColors.royalBlue,
            ])),
        child: Center(
            child: Padding(
          padding: EdgeInsets.all(sclW(context) * 25),
          child: Image.asset(
            "assets/img/logo-emotion.png",
          ),
        )),
      ),
    );
  }
}
