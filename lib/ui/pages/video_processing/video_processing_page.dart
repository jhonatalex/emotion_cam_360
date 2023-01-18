import 'dart:io';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/ui/pages/video_processing/video_util.dart';

import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_video/return_code.dart';
import 'package:ffmpeg_kit_flutter_video/statistics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../../repositories/abstractas/responsive.dart';
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

  var file = Get.arguments;

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
    FFmpegKitConfig.init().then((_) {
      VideoUtil.prepareAssets();
    });

    _init();
  }

  Future<void> _init() async {
    print(chalk.yellow.bold("_init iniciado"));
    await Future.delayed(const Duration(seconds: 3));
    encodeVideo();
  }

  void encodeVideo() {
    print(chalk.yellow.bold("encode video"));
    final eventProvider =
        Provider.of<EventoActualPreferencesProvider>(context, listen: false);

    VideoUtil.assetPath(VideoUtil.LOGO).then((logoPath) {
      VideoUtil.assetPath(VideoUtil.BGCREDITOS).then((endingPath) {
        VideoUtil.assetPath(VideoUtil.MUSIC1).then((music1Path) {
          getVideoFile().then((videoFile) {
            final styleVideoOne = VideoUtil.styleVideoOne(
              eventProvider.logoPrefrerences,
              endingPath,
              file[1], //videoProvider.pathPreferences,
              eventProvider.musicPrefrerences,
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
              duration: Duration(seconds: 1),
              opacity: _opacity,
              child: BackgroundGradient(context)),
          dinamicText(videoProvider),
        ],
      ),
    );
  }

  Future<File> getVideoFile() async {
    const String video = "video.mp4"; //$extension";
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return File("${documentsDirectory.path}/$video");
  }

  void updateProgressDialog() {
    var statistics = _statistics;
    if (statistics == null || statistics.getTime() < 0) {
      return;
    }

    int timeInMilliseconds = statistics.getTime();
    int totalVideoDuration = VideoUtil.timeTotal * 1000;

    completePercentage = (timeInMilliseconds * 100) ~/ totalVideoDuration;
    print(chalk.red.bold(completePercentage));
    if (completePercentage <= 100) {
      if (isEncoded == false) {
        setState(() {
          _opacity = completePercentage / 100;
        });
      }
    }
  }

  dinamicText(videoProvider) {
    if (isEncoded == false && completePercentage < 100) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 80,
                width: 80,
                child: const CircularProgressIndicator(
                  backgroundColor: AppColors.violet,
                  color: AppColors.royalBlue,
                  strokeWidth: 8,
                ),
              ),
              Text(
                "$completePercentage % ",
                style: TextStyle(fontSize: sclW(context) * 3),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            " Procesando video...",
            style: TextStyle(fontSize: sclW(context) * 3),
          ), /* 
          ElevatedButton(
              onPressed: () {
                Get.offNamed(RouteNames.showVideo);
              },
              child: Text("ir a show video")), */
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
              future: getVideoFile(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  fileEncoded = snapshot.data as File;
                  fileEncoded.readAsBytes().then((valueBytes) {
                    videoProvider.saveVideoPrefrerence(valueBytes);
                    videoProvider.savePathPrefrerence(fileEncoded.path);

                    Get.offNamed(RouteNames.showVideo);
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
