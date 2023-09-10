import 'package:emotion_cam_360/ui/pages/video_processing/video_util.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_header.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_eventos.dart';
import 'package:emotion_cam_360/ui/widgets/drawer.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:flutter/material.dart';

import '../../widgets/imgtextbutton.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    VideoUtil.prepareAssets();
    //final userProvider = Provider.of<SesionPreferencerProvider>(context);

    return const Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.vulcan,
      body: Content(),
      /*Obx(() {
        //if (userController.isLoading.value) {
         // return const Center(child: CircularProgressIndicator());
        //}
        //return content;
      }),*/
      drawer: MyDrawer(),
      //if(emailUserToken!='') MyDrawer(emailUserToken),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: sclH(context) * 40, child: const CarrucelHeader()),
          SizedBox(
            height: sclH(context) * 20,
            child: const Center(
              child: ImgTextButton(),
            ),
          ),
          SizedBox(height: sclH(context) * 40, child: const CarrucelStyles()),
        ],
      ),
    );
  }
}
