import 'dart:io';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/pages/video_processing/video_util.dart';

import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_video/return_code.dart';
import 'package:ffmpeg_kit_flutter_video/statistics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
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

    final eventProvider =
        Provider.of<EventoActualPreferencesProvider>(context, listen: false);
    VideoUtil.assetPath(VideoUtil.LOGO).then((logoPath) {
      VideoUtil.assetPath(VideoUtil.BGCREDITOS).then((endingPath) {
        VideoUtil.assetPath(VideoUtil.MUSIC1).then((music1Path) {
          getVideoFile().then((videoFile) {
            final styleVideoOne = VideoUtil.styleVideoOne(
              eventProvider.eventPrefrerences.overlay,
              endingPath,
              file, //videoProvider.pathPreferences,
              eventProvider.eventPrefrerences.music,
              videoFile.path,
            );
            FFmpegKit.executeAsync(
                    styleVideoOne,
                    (session) async {
                      final state = FFmpegKitConfig.sessionStateToString(
                          await session.getState());
                      final returnCode = await session.getReturnCode();
                      final failStackTrace = await session.getFailStackTrace();
                      final duration = await session.getDuration();

                      if (ReturnCode.isSuccess(returnCode)) {
                        print(chalk.yellow.bold(
                            "Aplicación de efectos Completa $duration milliseconds. now Show video"));
                        setState(() {
                          isEncoded == true;
                        });
                      } else {
                        print(chalk.white.bold(
                            "aplicación de efectos fallida. Please check log for the details."));
                        print(chalk.white.bold(
                            "aplicación de efectos fallida. with state $state and rc $returnCode.${notNull(failStackTrace, "\\n")}"));
                      }
                    },
                    (log) => print(log.getMessage()),
                    (statistics) {
                      _statistics = statistics;
                      updateProgressDialog();
                    })
                .then((session) => print(chalk.white.bold(
                    "Async FFmpeg process started with sessionId ${session.getSessionId()}.")));
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
    print(chalk.white.bold(file));
    return File(file);
  }

  void updateProgressDialog() {
    var statistics = _statistics;
    if (statistics == null || statistics.getTime() < 0) {
      return;
    }

    int timeInMilliseconds = statistics.getTime();
    int totalVideoDuration = VideoUtil.timeTotal * 1000;

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
                                color: const Color.fromARGB(255, 215, 241, 216),
                              ),
                            ),
                          ],
                        )
                      : LiquidCircularProgressIndicator(
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
                        ),
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
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Procesamiento completo...\n\nDisfruta tu experiencia.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: sclW(context) * 3)),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: getVideoFile1(),
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
                  print(chalk.white.bold(fileEncoded.path));
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
