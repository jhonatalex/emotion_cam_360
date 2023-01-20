import 'package:carousel_slider/carousel_slider.dart';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repositories/abstractas/responsive.dart';

class CarrucelStyles extends StatefulWidget {
  const CarrucelStyles({super.key});

  @override
  State<CarrucelStyles> createState() => _CarrucelStylesState();
}

class _CarrucelStylesState extends State<CarrucelStyles> {
  // final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

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
  final _evenController = Get.find<EventController>();
  @override
  build(BuildContext context) {
    return Obx(() {
      var listEvents = _evenController.eventos;
      if (listEvents.length == 0) {
        for (var i = 0; i < 3; i++) {
          listEvents.add(
            EventEntity("id", "Evento", "music",
                overlay: "asset/img/logo-emotion.png"),
          );
        }
      }

      print(chalk.yellow.bold(listEvents.length));
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
        items: listEvents.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () =>
                    Get.toNamed(RouteNames.videoListPage, arguments: i!.name),
                child: Container(
                    width: sclH(context) * 30,
                    //margin: EdgeInsets.symmetric(horizontal: sclH(context) / 2),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/bg_sld.jpg"),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          i!.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.royalBlue, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image.network(
                          i!.overlay,
                          scale: 10,
                        )
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
