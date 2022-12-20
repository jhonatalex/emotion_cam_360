import 'package:emotion_cam_360/ui/widgets/carrucel_header.dart';
import 'package:emotion_cam_360/ui/widgets/carrucel_styles.dart';
import 'package:emotion_cam_360/ui/widgets/drawer.dart';
import 'package:flutter/material.dart';

class FinishPage extends StatefulWidget {
  const FinishPage({Key? key}) : super(key: key);

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    final content = Container(
      color: const Color(0xff141220),
      child: ListView(
        children: [
          const CarrucelHeader(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                // foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                elevation: 0 // foreground
                ),
            onPressed: () {},
            child: Column(
              children: [
                Center(
                    child: Image.asset(
                  "assets/img/logo-emotion.png",
                  height: 200,
                )),
                const Text(
                  "INICIAR EXPERIENCIA 360°",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          const CarrucelStyles(),
        ],
      ),
    );

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(25)),
        ),
        Scaffold(
          extendBodyBehindAppBar: true,
          body: content,
          /*Obx(() {
            //if (userController.isLoading.value) {
             // return const Center(child: CircularProgressIndicator());
            //}
            //return content;
          }),*/
          drawer: const MyDrawer(),
          // bottomNavigationBar: MyBottomNavigationBar(),
        ),
      ],
    );
  }
}
