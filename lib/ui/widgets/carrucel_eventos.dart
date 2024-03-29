// ignore_for_file: unused_import, must_be_immutable

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/messenger_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'responsive.dart';

final _eventController = Get.find<EventController>();

class CarrucelStyles extends StatefulWidget {
  const CarrucelStyles({super.key});

  @override
  State<CarrucelStyles> createState() => _CarrucelStylesState();
}

class _CarrucelStylesState extends State<CarrucelStyles> {
  // final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            style: TextStyle(fontSize: sclW(context) * 5),
            "EVENTOS",
          ),
          SizedBox(
            width: double.infinity,
            height: sclH(context) * 32,
            child: PopularesSlider(),
          ),
        ],
      ),
    );
  }
}

class PopularesSlider extends StatelessWidget {
  String imgDefault = "assets/img/logo-emotion.png";

  //final _eventController = Get.put(EventController());

  PopularesSlider({super.key});

  @override
  build(BuildContext context) {
    return Obx(() {
      var listEvents = _eventController.eventos;
      if (listEvents.isEmpty) {
        for (var i = 0; i < 3; i++) {
          listEvents.add(
            const EventEntity("id", "Evento", "music",
                overlay: "assets/img/logo-emotion.png"),
          );
        }
      }
      return CarouselSlider(
        options: CarouselOptions(
            height: sclH(context) * 28,
            //aspectRatio: 15 / 9,
            viewportFraction: 0.35,
            enlargeFactor: 0.3,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            scrollDirection: Axis.horizontal,
            enlargeCenterPage: true),
        items: listEvents.map((event) {
          File imgDynamic = File(event.overlay);

          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  if (event!.name != "Evento") {
                    Get.toNamed(RouteNames.videoListPage, arguments: event);
                    // print(chalk.white.bold(event!.overlay));
                  } else {
                    MessengerSnackBar(context, "No se han cargado eventos");
                  }
                },
                child: Container(
                    width: sclH(context) * 35,
                    //margin: EdgeInsets.symmetric(horizontal: sclH(context) / 2),
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage("assets/img/bg_sld.jpg"),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(25)),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: sclH(context) * 1.5,
                              //left: sclW(context) * 5,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              event!.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.royalBlue,
                                  fontSize: sclW(context) * 5),
                            ),
                          ),
                          SizedBox(
                            height: sclH(context) * 1,
                          ),
                          event!.name == "Evento"
                              ? Image.asset(
                                  event!.overlay,
                                  width: sclW(context) * 30,
                                  height: sclW(context) * 30,
                                )
                              : imgDynamic.existsSync()
                                  ? Image.file(
                                      imgDynamic,
                                      width: sclW(context) * 30,
                                      height: sclW(context) * 30,
                                    )
                                  : Image.asset(
                                      "assets/img/logo-emotion.png",
                                      width: sclW(context) * 30,
                                      height: sclW(context) * 30,
                                    ),
                          SizedBox(
                            height: sclH(context) * 8,
                          )
                        ],
                      ),
                    )),
              );
            },
          );
        }).toList(),
      );
    });
  }
}
