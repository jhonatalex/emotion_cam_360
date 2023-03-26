import 'dart:io';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../routes/route_names.dart';

class ShowVideoPage extends StatefulWidget {
  final String filePath;

  const ShowVideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _ShowVideoPageState createState() => _ShowVideoPageState();
}

class _ShowVideoPageState extends State<ShowVideoPage> {
  late VideoPlayerController _videoPlayerController;
  //late final eventoActual;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    //getMyEventClass();
  }

/*   ///CAMBIAR VARIABLE DEL COMBOBOX O SELECT DROPDOWN
  Future<EventEntity?> getMyEvent() async {
    final snapshot = await firestore
        .doc(
            'user_${Get.find<AuthController>().authUser.value!.uid}/Santiago_fecha_8-1-2023')
        .get();
    if (snapshot.exists) return EventEntity.fromFirebaseMap(snapshot.data()!);
    return null;
  } */

  //Future<void> getMyEventClass() async {
  // eventoActual = await getMyEvent();
  // }

  Future _initVideoPlayer(file) async {
    _videoPlayerController = VideoPlayerController.file(File(file));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(false);
    await Future.delayed(const Duration(seconds: 1));
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoPreferencesProvider>(context);
    var file = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista Previa'),
        elevation: 0,
        backgroundColor: Colors.black26,
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed(RouteNames.videoPage);
            },
            icon: const Icon(Icons.video_call)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              //Get.offNamed(RouteNames.uploadVideo);
              Get.offAllNamed(RouteNames.uploadVideo);
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(videoProvider.pathPreferences),
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
        backgroundColor: AppColors.violet,
        onPressed: () {
          _videoPlayerController.value.isPlaying
              ? _videoPlayerController.pause()
              : _videoPlayerController.play();
        },
        child: const Icon(
          /* 
          _videoPlayerController.value.isPlaying
              ? Icons.pause
              :  */
          Icons.play_arrow,
        ),
      ),
    );
  }
}
