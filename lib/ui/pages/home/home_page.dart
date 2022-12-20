// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_header.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_styles.dart';
import 'package:emotion_cam_360/ui/widgets/drawer.dart';
import 'package:emotion_cam_360/ui/widgets/mybottomnavigationbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      color: Color(0xff141220),
      child: ListView(
        children: [
          CarrucelHeader(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                // foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                elevation: 0 // foreground
                ),
            onPressed: () {
              Get.offNamed(RouteNames.menu);
            },
            child: Column(
              children: [
                Center(
                    child: Image.asset(
                  "assets/img/logo-emotion.png",
                  height: 200,
                )),
                Text(
                  "INICIAR EXPERIENCIA 360°",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          CarrucelStyles(),
        ],
      ),
    );

    return Stack(
      children: [
        Scaffold(
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
        ),
      ],
    );
  }
}
