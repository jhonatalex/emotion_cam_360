import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoListPage extends StatelessWidget {
  VideoListPage({super.key});

  final _evenController = Get.find<EventController>();
  var id = Get.arguments;
  @override
  Widget build(BuildContext context) {
    var listEvents = _evenController.eventos;
    return Stack(
      children: [
        BackgroundGradient(context),
        Scaffold(
          appBar: AppBar(
            title: Text(id),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Center(
                child: Text(
                  'Lista de Videos del Evento $id',
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
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Get.toNamed(RouteNames.videoViewerPage,
                              arguments: "video"),
                          child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "video $index",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: sclH(context) * 2.5,
                                    ),
                                  ),
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
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
