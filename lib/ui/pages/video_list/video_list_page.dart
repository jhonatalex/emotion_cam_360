import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoListPage extends StatelessWidget {
  VideoListPage({super.key});

  final _evenController = Get.find<EventController>();
  var eventSelected = Get.arguments;
  @override
  Widget build(BuildContext context) {
    //var listEvents = _evenController.eventos;
    print(chalk.white.bold(eventSelected));
    String nameEvent = eventSelected[0];
    List videosEvent = ["Video 1", "Video 2", "Video 3"];
    //List videosEvent = eventSelected[1];

    return Stack(
      children: [
        BackgroundGradient(context),
        Scaffold(
          appBar: AppBar(
            title: Text(
              eventSelected[0].toString().toUpperCase(),
              style: TextStyle(fontSize: sclW(context) * 5),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Center(
                child: Text(
                  'Lista de Videos del Evento ${eventSelected[0]}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: sclH(context) * 2),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 10, //videosEvent.length
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Get.toNamed(RouteNames.videoViewerPage,
                              arguments:
                                  //videosEvent[index],
                                  //"/data/user/0/com.example.emotion_cam_360/cache/REC252710529.mp4",
                                  "https://firebasestorage.googleapis.com/v0/b/emotion360-72a62.appspot.com/o/PbHvDg0ypoMtcmcK1Dpzx1NUr9y1%2Fvideos360%2Fvideo.mp4?alt=media&token=67148754-033d-4d0f-8111-836cabbe3927"),
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
                                      fontSize: sclH(context) * 2.5,
                                    ),
                                  ),
                                  Icon(
                                    Icons.play_arrow,
                                    color: AppColors.violet,
                                    size: sclH(context) * 10,
                                  )
                                ],
                              )),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
