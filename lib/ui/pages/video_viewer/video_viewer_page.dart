import 'dart:io';

import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:emotion_cam_360/ui/pages/video_viewer/video_viewer_controller.dart';
import 'package:emotion_cam_360/ui/widgets/background_gradient.dart';
import 'package:emotion_cam_360/ui/widgets/share_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

class VideoViewerPage extends StatefulWidget {
  @override
  State<VideoViewerPage> createState() => _VideoViewerPageState();
}

class _VideoViewerPageState extends State<VideoViewerPage> {
  var video = Get.arguments;
  bool isData = true;
  late VideoPlayerController _videoPlayerController;

  final vVC = Get.find<VideoViewerController>();

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  Future _initVideoPlayer(url) async {
    _videoPlayerController = VideoPlayerController.network(url);
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(false);
    //await Future.delayed(Duration(seconds: 1));
    await _videoPlayerController.play();

    vVC.isPause.value = false;
  }

  playVideo() {
    _videoPlayerController.play();
    vVC.isPause.value = false;
  }

  pauseVideo() {
    _videoPlayerController.pause();
    vVC.isPause.value = true;
  }

  @override
  Widget build(BuildContext context) {
    //final videoProvider = Provider.of<VideoPreferencesProvider>(context);

    //validar si es videoshow o video viewer verificando
    // si el link proviene de la data o internet
    // y asi poder usar isData como validador
    String data = video as String;
    data = data.substring(1, 5);
    data == "data"
        ? isData = true
        : isData =
            false; /* 
    print(chalk.white.bold("Video path $video"));
    print(chalk.white.bold("Video path $isData")); */
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "REPRODUCIR VIDEO",
          style: TextStyle(fontSize: sclW(context) * 5),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: isData
            ? IconButton(
                onPressed: () {
                  Get.offAllNamed(RouteNames.videoPage);
                },
                icon: Icon(Icons.video_call))
            : IconButton(
                onPressed: () {
                  Get.back();
                  // Get.offAllNamed(RouteNames.home);
                  //por ahora mientras consigo como volver jeje
                },
                icon: const Icon(Icons.arrow_back)),
        actions: [
          isData
              ? IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    Get.offAllNamed(RouteNames.uploadVideo);
                  },
                )
              : Sharebuttons(
                  video,
                  "",
                ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BackgroundGradient(context),
          Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      FutureBuilder(
                        future: _initVideoPlayer(
                            video), //videoProvider.pathPreferences),
                        builder: (context, state) {
                          if (state.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return AspectRatio(
                              aspectRatio:
                                  _videoPlayerController.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController),
                            );
                          }
                        },
                      ),
                      Obx(() {
                        return Icon(
                          Icons.pause,
                          color: vVC.isPause.value
                              ? AppColors.violet
                              : Colors.transparent,
                          size: sclH(context) * 5,
                        );
                      }),
                      Column(
                        children: [
                          const Spacer(),
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: pauseVideo,
                                  icon: Icon(
                                    Icons.pause,
                                    color: vVC.isPause.value
                                        ? AppColors.violet
                                        : Colors.white,
                                  ),
                                  iconSize: vVC.isPause.value
                                      ? sclH(context) * 8
                                      : sclH(context) * 5,
                                ),
                                IconButton(
                                  onPressed: playVideo,
                                  icon: Icon(
                                    Icons.play_arrow,
                                    color: vVC.isPause.value
                                        ? Colors.white
                                        : AppColors.violet,
                                  ),
                                  iconSize: vVC.isPause.value
                                      ? sclH(context) * 5
                                      : sclH(context) * 8,
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
