// ignore_for_file: prefer_const_constructors

import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_header.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_styles.dart';
import 'package:emotion_cam_360/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repositories/abstractas/responsive.dart';
import '../../routes/route_names.dart';
import '../../widgets/imgtextbutton.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final content = ListView(
      children: const [
        CarrucelHeader(),
        ImgTextButton(),
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
    );
  }
}
