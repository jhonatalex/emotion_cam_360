import 'dart:io';
import 'package:chalkdart/chalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/controllers/auth_controller.dart';
import 'package:emotion_cam_360/entities/event.dart';
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
  late final eventoActual;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getMyEventClass();
  }

  Future<EventEntity?> getMyEvent() async {
    final snapshot = await firestore
        .doc('user_${Get.find<AuthController>().authUser.value!.uid}/Barinas')
        .get();
    if (snapshot.exists) return EventEntity.fromFirebaseMap(snapshot.data()!);
    return null;
  }

  Future<void> getMyEventClass() async {
    eventoActual = await getMyEvent();
  }

  Future _initVideoPlayer(file) async {
    _videoPlayerController = VideoPlayerController.file(File(file));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(false);
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    //filePath: file!.path
    var file = Get.arguments;

    print(chalk.brightGreen(file[0]));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista Previa'),
        elevation: 0,
        backgroundColor: Colors.black26,
        leading: IconButton(
            onPressed: () {
              Get.offNamed(RouteNames.videoProcessing);
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              //print('do something with the file');
              //Get.offNamed(RouteNames.uploadVideo);
              Get.offNamed(RouteNames.uploadVideo,
                  arguments: [file[0], file[1], eventoActual]);
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
            return Center(
              child: AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _videoPlayerController.value.isPlaying
              ? _videoPlayerController.pause()
              : _videoPlayerController.play();
        },
        child: Icon(
          _videoPlayerController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
    );
  }
}
