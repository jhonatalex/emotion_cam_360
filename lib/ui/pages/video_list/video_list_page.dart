// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoListPage extends StatelessWidget {
  VideoListPage({super.key});

  // final _evenController = Get.find<EventController>();

  EventEntity eventSelected = Get.arguments;
  @override
  Widget build(BuildContext context) {
    //var listEvents = _evenController.eventos;
    print(chalk.white.bold(eventSelected));

    String nameEvent = eventSelected.name;
    String imageEvent = eventSelected.overlay;
    //List videosEvent = ["Video 1", "Video 2", "Video 3"];
    List? videosEvent = eventSelected.videos;

    return Stack(
      children: [
        BackgroundGradient(context),
        Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "EVENTO: ${nameEvent.toString().toUpperCase()}",
                style: TextStyle(fontSize: sclW(context) * 5),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Opacity(
                opacity: 0.25,
                child: Image.file(
                  File(imageEvent),
                ),
              ),
              videosEvent?.length == null
                  ? Text(
                      "Aún no se han cargado videos.",
                      style: TextStyle(
                        fontSize: sclW(context) * 5,
                      ),
                    )
                  : Container(),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: videosEvent?.length ?? 0, //videosEvent.length
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => Get.toNamed(RouteNames.videoViewerPage,
                            arguments: videosEvent![index]),
                        //videosEvent[index],
                        //"/data/user/0/com.example.emotion_cam_360/cache/REC252710529.mp4",
                        //"https://firebasestorage.googleapis.com/v0/b/emotion360-72a62.appspot.com/o/PbHvDg0ypoMtcmcK1Dpzx1NUr9y1%2Fvideos360%2Fvideo.mp4?alt=media&token=67148754-033d-4d0f-8111-836cabbe3927"),
                        child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Video ${index + 1}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: sclH(context) * 2,
                                  ),
                                ),
                                Icon(
                                  Icons.play_arrow,
                                  color: AppColors.violet,
                                  size: sclH(context) * 8,
                                )
                              ],
                            )),
                      );
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
