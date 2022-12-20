// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          SizedBox(
            height: 10,
          ),
          Center(
              child: Image.asset(
            "assets/img/logo-emotion.png",
            height: 200,
          )),
          Text(
            "EMOTION CAM 360",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 38.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EMOTION CAM 360',
          style: TextStyle(fontSize: 30),
        ),
        elevation: 0.0,
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      extendBodyBehindAppBar: true,
      body: content,
      /*Obx(() {
        //if (userController.isLoading.value) {
         // return const Center(child: CircularProgressIndicator());
        //}
        //return content;
      }),*/
      drawer: Drawer(
        backgroundColor: Color.fromARGB(0, 20, 18, 32),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 150, bottom: 50),
              child: Text(
                'EMOTION \n CAM 360',
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              tileColor: Colors.black38,
              leading: Icon(
                Icons.home,
              ),
              title: Text('Home'),
            ),
            ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              tileColor: Colors.black38,
              leading: Icon(
                Icons.home,
              ),
              title: Text('Home'),
            ),
            ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              tileColor: Colors.black38,
              leading: Icon(
                Icons.home,
              ),
              title: Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
