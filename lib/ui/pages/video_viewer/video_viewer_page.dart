import 'dart:io';

import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/pages/video_viewer/video_viewer_controller.dart';
import 'package:emotion_cam_360/ui/widgets/background_gradient.dart';
import 'package:emotion_cam_360/ui/widgets/share_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoViewerPage extends StatelessWidget {
  var video = Get.arguments;

  late VideoPlayerController _videoPlayerController;

  final vVC = Get.find<VideoViewerController>();

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
    print(chalk.white.bold("Video path $video"));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "REPRODUCIR VIDEO",
          style: TextStyle(fontSize: sclW(context) * 5),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BackgroundGradient(context),
          Column(
            children: [
              Expanded(
                child: Container(
                  //margin: EdgeInsets.all(20),
                  color: Colors.black,
                  //height: 200,
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
                            return Center(
                              child: AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: VideoPlayer(_videoPlayerController),
                              ),
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
                                  iconSize: sclH(context) * 5,
                                ),
                                IconButton(
                                  onPressed: playVideo,
                                  icon: Icon(
                                    Icons.play_arrow,
                                    color: vVC.isPause.value
                                        ? Colors.white
                                        : AppColors.violet,
                                  ),
                                  iconSize: sclH(context) * 5,
                                ),
                              ],
                            );
                          }),
                          const Sharebuttons(),
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
