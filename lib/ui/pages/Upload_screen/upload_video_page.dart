import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class UploadVideoPage extends StatelessWidget {
  const UploadVideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final UploadVideoController controller = Get.find<UploadVideoController>();
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
        child: Expanded(
          child: Column(
            children: [
              Center(
                  child: Padding(
                padding: EdgeInsets.all(sclW(context) * 25),
                child: SimpleCircularProgressBar(
                  progressColors: const [
                    Colors.cyan,
                    Color.fromARGB(255, 64, 251, 104)
                  ],
                  mergeMode: true,
                  onGetText: (double value) {
                    return Text(
                      '${value.toInt()} %',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              )),
              Container(
                child: const Text(
                  'Cargando Video a la nube....',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
