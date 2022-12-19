// ignore_for_file: prefer_const_constructors

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
      color: Color.fromARGB(255, 0, 0, 0),
      child: Center(
        child: Column(
          children: [
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
      ),
    );

    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(211, 5, 5, 5)),
      body: content,
      /*Obx(() {
        //if (userController.isLoading.value) {
         // return const Center(child: CircularProgressIndicator());
        //}
        //return content;
      }),*/
      drawer: Drawer(
        child: Drawer(backgroundColor: Colors.transparent),
      ),
    );
  }
}
