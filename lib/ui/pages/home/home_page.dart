import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_header.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_eventos.dart';
import 'package:emotion_cam_360/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';

import '../../widgets/imgtextbutton.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    //final userProvider = Provider.of<SesionPreferencerProvider>(context);

    final content = Column(
      children: const [
        CarrucelHeader(),
        Expanded(child: Center(child: ImgTextButton())),
        CarrucelStyles(),
      ],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.vulcan,
      body: content,
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
