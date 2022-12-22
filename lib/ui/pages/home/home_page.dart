// ignore_for_file: prefer_const_constructors

import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_header.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_styles.dart';
import 'package:emotion_cam_360/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_names.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final content = Container(
      color: AppColors.vulcan,
      child: Column(
        children: [
          CarrucelHeader(),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                //foregroundColor: Colors.white,
                //primary: Colors.transparent,
                padding: EdgeInsets.all(20),
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                elevation: 2 // foreground
                ),
            onPressed: () {
              Get.offNamed(RouteNames.menu);
            },
            child: Text(
              "INICIAR EXPERIENCIA 360°",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          SizedBox(height: 50),
          CarrucelStyles(),
        ],
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: content,
      /*Obx(() {
            //if (userController.isLoading.value) {
             // return const Center(child: CircularProgressIndicator());
            //}
            //return content;
          }),*/
      drawer: MyDrawer(),
      // bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
