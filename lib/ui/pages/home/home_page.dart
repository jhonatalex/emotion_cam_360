// ignore_for_file: prefer_const_constructors

import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/entities/user.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_header.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_styles.dart';
import 'package:emotion_cam_360/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../../controllers/event_controller.dart';
import '../../widgets/imgtextbutton.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    //final _evenController = Get.find<EventController>();
    //final emailUser = getEmailUser(_evenController);
    //print(chalk.brightGreen('LOG AQUI $emailUser'));

    final userProvider = Provider.of<SesionPreferencerProvider>(context);

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
      body:
          Container(height: MediaQuery.of(context).size.height, child: content),
      /*Obx(() {
        //if (userController.isLoading.value) {
         // return const Center(child: CircularProgressIndicator());
        //}
        //return content;
      }),*/
      drawer: MyDrawer(userProvider.users),
    );
  }
}
