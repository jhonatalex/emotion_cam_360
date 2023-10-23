import 'dart:io';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/pages/video_processing/video_util.dart';
import 'package:ffmpeg_kit_flutter_min_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_min_gpl/return_code.dart';
import 'package:ffmpeg_kit_flutter_min_gpl/statistics.dart';
/* 
import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_video/return_code.dart';
import 'package:ffmpeg_kit_flutter_video/statistics.dart'; */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/responsive.dart';
import '../../routes/route_names.dart';
import '../../widgets/background_gradient.dart';

class VideoProcessingPage extends StatefulWidget {
  const VideoProcessingPage({super.key});

  @override
  State<VideoProcessingPage> createState() => _VideoProcessingPageState();
}

class _VideoProcessingPageState extends State<VideoProcessingPage> {
  String notNull(String? string, [String valuePrefix = ""]) {
    return (string == null) ? "" : valuePrefix + string;
  }

  //final String _selectedCodec = "mpeg4";
  late String extension;
  late Statistics? _statistics;
  int completePercentage = 0;
  late File fileEncoded;
  double _opacity = 0;
  bool isEncoded = false;
  double showbutton = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 3));
    encodeVideo();
  }

  void encodeVideo() {
    var file = Get.arguments;

    FFmpegKit.cancel();
    final eventProvider =
        Provider.of<EventoActualPreferencesProvider>(context, listen: false);
    VideoUtil.assetPath(VideoUtil.logo).then((logoPath) {
      VideoUtil.assetPath(
              VideoUtil.videoCredito[settingsController.fondoVideo.value])
          .then((endingPath) {
        VideoUtil.assetPath(VideoUtil.music1).then((music1Path) {
          VideoUtil.assetPath("marco${desingController.currentMarco.value}.png")
              .then((marcoPath) {
            getVideoFile().then((videoFile) {
              final styleVideoOne = VideoUtil.styleVideoOne(
                eventProvider.eventPrefrerences.overlay,
                endingPath,
                file, //videoProvider.pathPreferences,
                eventProvider.eventPrefrerences.music,
                videoFile.path,
                marcoPath,
              );

              FFmpegKit.executeAsync(
                      styleVideoOne,
                      (session) async {
                        final returnCode = await session.getReturnCode();
                        /* 
                      final state = FFmpegKitConfig.sessionStateToString(
                          await session.getState());
                      final failStackTrace = await session.getFailStackTrace();
                      final duration = await session.getDuration(); */

                        if (ReturnCode.isSuccess(returnCode)) {
                          setState(() {
                            isEncoded == true;
                          });
                        } else {}
                      },
                      (log) => (print(log.getMessage())), //{}, //
                      (statistics) {
                        _statistics = statistics;
                        updateProgressDialog();
                      })
                  /* .then((session) => print(chalk.white.bold(
                    "Async FFmpeg process started with sessionId ${session.getSessionId()}.")))
                    */
                  ;
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoPreferencesProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.vulcan,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _opacity,
              child: BackgroundGradient(context)),
          dinamicText(videoProvider, context),
        ],
      ),
    );
  }

  Future<File> getVideoFile() async {
    const String video = "video.mp4"; //$extension";
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return File("${documentsDirectory.path}/$video");
  }

  Future<File> getVideoFile1() async {
    var file = Get.arguments;
    //print(chalk.white.bold(file));
    return File(file);
  }

  void updateProgressDialog() {
    var statistics = _statistics;
    if (statistics == null || statistics.getTime() < 0) {
      return;
    }

    int timeInMilliseconds = statistics.getTime();
    int totalVideoDuration = settingsController.timeTotal.value * 1000;

    completePercentage = (timeInMilliseconds * 100) ~/ totalVideoDuration;
    //print(chalk.red.bold(completePercentage));
    if (completePercentage <= 100) {
      if (isEncoded == false) {
        setState(() {
          _opacity = completePercentage / 100;
        });
      }
    }
  }

  dinamicText(videoProvider, context) {
    if (isEncoded == false && completePercentage < 100) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: sclW(context) * 40,
                width: sclW(context) * 40,
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 375),
                    child: completePercentage == 100
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.check_rounded,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Completado',
                                style: TextStyle(
                                  fontSize: sclW(context) * 4,
                                  color:
                                      const Color.fromARGB(255, 215, 241, 216),
                                ),
                              ),
                            ],
                          )
                        : LiquidCircularProgressIndicator(
                            value: completePercentage / 100, // Defaults to 0.5.
                            valueColor: const AlwaysStoppedAnimation(AppColors
                                .royalBlue), // Defaults to the current Theme's accentColor.
                            backgroundColor: Colors
                                .white, // Defaults to the current Theme's backgroundColor.
                            borderColor: const Color.fromARGB(255, 96, 79, 239),
                            borderWidth: 1.0,
                            direction: Axis
                                .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                            center: Text(
                              "$completePercentage %",
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.black),
                            ),
                          ) /* Text(
                            "$completePercentage %",
                            style: const TextStyle(fontSize: 40),
                          ) */
                    /* LiquidCircularProgressIndicator(
                          value: completePercentage.toDouble() / 100,
                          valueColor: const AlwaysStoppedAnimation(
                            AppColors.royalBlue,
                          ),
                          backgroundColor: Colors.white,
                          direction: Axis.vertical,
                          center: Text(
                            "$completePercentage%",
                            style: const TextStyle(
                                fontFamily: "Verdana",
                                color: Colors.black87,
                                fontSize: 25.0),
                          ),
                        ), */
                    ),
              ),

              /*  const CircularProgressIndicator(
                  backgroundColor: AppColors.violet,
                  color: AppColors.royalBlue,
                  strokeWidth: 8,
                ),
              ),
              Text(
                "$completePercentage % ",
                style: TextStyle(fontSize: sclW(context) * 3),
              ), */
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            " Procesando video...",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: sclW(context) * 4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          /* ElevatedButton(
              onPressed: () {
                encodeVideo();
              },
              child: const Text("again")),
          ElevatedButton(
              onPressed: () {
                FFmpegKit.cancel();
              },
              child: const Text("CANCELAR TODO")) */
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // solo para no restablecer....↓↓↓↓
          /*  ElevatedButton(
              onPressed: () {
                encodeVideo();
              },
              child: Text("again")),
          ElevatedButton(
              onPressed: () {
                Get.offNamed(RouteNames.videoViewerPage,
                    arguments: fileEncoded.path);
              },
              child: Text("video viewer")), */
//lo anterior se debe quitar  ↑↑↑

          Text("Procesamiento completo...\n\nDisfruta tu experiencia.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: sclW(context) * 5)),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: getVideoFile(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  fileEncoded = snapshot.data as File;
                  fileEncoded.readAsBytes().then((valueBytes) {
                    videoProvider.saveVideoPrefrerence(valueBytes);
                    videoProvider.savePathPrefrerence(fileEncoded.path);

                    Get.offNamed(RouteNames.videoViewerPage,
                        arguments: fileEncoded.path);
                    // Get.offNamed(RouteNames.showVideo);
                    // arguments: [valueBytes, fileEncoded.path]);
                  });
                  //print(chalk.white.bold(fileEncoded.path));
                  return Container();
                } else {
                  return Container();
                }
              }),
        ],
      );
    }
  }
}
