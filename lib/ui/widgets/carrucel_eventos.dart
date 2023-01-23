import 'package:carousel_slider/carousel_slider.dart';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/messenger_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repositories/abstractas/responsive.dart';

class CarrucelStyles extends StatelessWidget {
  const CarrucelStyles({super.key});

  // final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "EVENTOS",
          style: TextStyle(fontSize: sclW(context) * 5),
        ),
        SizedBox(
          width: double.infinity,
          height: sclH(context) * 35,
          child: PopularesSlider(),
        ),
      ],
    );
  }
}

class PopularesSlider extends StatelessWidget {
  String imgDefault = "assets/img/logo-emotion.png";

  final _eventController = Get.find<EventController>();

  @override
  build(BuildContext context) {
    _eventController.getAllMyEventController();
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
            height: sclH(context) * 30,
            //aspectRatio: 15 / 9,
            viewportFraction: 0.4,
            enlargeFactor: 0.3,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            scrollDirection: Axis.horizontal,
            enlargeCenterPage: true),
        items: listEvents.map((event) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  if (event!.overlay != imgDefault) {
                    Get.toNamed(RouteNames.videoListPage, arguments: event);
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
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          event!.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: AppColors.royalBlue, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Image.asset(
                          imgDefault,
                          scale: 8,
                        ),
                      ],
                    )),
              );
            },
          );
        }).toList(),
      );
    });
  }
}
