import 'dart:io';
import 'package:chalkdart/chalk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../pages/Upload_screen/upload_video_page.dart';
import '../routes/route_names.dart';

class ShowVideoPage extends StatefulWidget {
  final String filePath;

  const ShowVideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _ShowVideoPageState createState() => _ShowVideoPageState();
}

class _ShowVideoPageState extends State<ShowVideoPage> {
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer(file) async {
    _videoPlayerController = VideoPlayerController.file(File(file));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    //filePath: file!.path
    var file = Get.arguments;

    print(chalk.brightGreen(file[1]));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista Previa'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              //print('do something with the file');
              //Get.offNamed(RouteNames.uploadVideo);
              Get.offNamed(RouteNames.uploadVideo,
                  arguments: [file, widget.filePath]);
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(file[1]),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController);
          }
        },
      ),
    );
  }
}
