import 'dart:io';

import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/widgets/background_gradient.dart';
import 'package:emotion_cam_360/ui/widgets/share_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoViewerPage extends StatelessWidget {
  var video = Get.arguments;

  late VideoPlayerController _videoPlayerController;

  Future _initVideoPlayer(file) async {
    _videoPlayerController = VideoPlayerController.file(File(file));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(false);
    await Future.delayed(Duration(seconds: 1));
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    //final videoProvider = Provider.of<VideoPreferencesProvider>(context);
    print(chalk.white.bold("Video path $video"));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reproducir $video".toString().toUpperCase(),
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
              SizedBox(
                height: 60,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  color: Colors.black,
                  //height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.pause),
                            iconSize: sclH(context) * 5,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.play_arrow),
                            iconSize: sclH(context) * 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Sharebuttons(),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}
