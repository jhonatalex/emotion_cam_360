import 'dart:io';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/ui/pages/video_processing/video_util.dart';
import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_video/return_code.dart';
import 'package:ffmpeg_kit_flutter_video/statistics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
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
    await Future.delayed(const Duration(seconds: 3));
    encodeVideo();
  }

  void encodeVideo() {
    VideoUtil.assetPath(VideoUtil.LOGO).then((logoPath) {
      VideoUtil.assetPath(VideoUtil.ENDING).then((endingPath) {
        VideoUtil.assetPath(VideoUtil.VIDEO360).then((video360Path) {
          VideoUtil.assetPath(VideoUtil.MUSIC1).then((music1Path) {
            getVideoFile().then((videoFile) {
              // IF VIDEO IS PLAYING STOP PLAYBACK

              final styleVideoOne = VideoUtil.styleVideoOne(
                logoPath,
                endingPath,
                file[1], //video360Path
                music1Path,
                videoFile.path,
                //↑↑ para que el video dde salida tenga
                //// el mismo nombre que el de entrada

                // videoCodec,
                //this.getPixelFormat(),
                //this.getCustomOptions()
              );
              print(chalk.white.bold(file[1]));
              //crear video creditos esta funcion deberia estar
              // despues que el cliente cargue el logo para
              //que el video de los creditos ya esté preparado

              //Esta produce el video con slowmotion
              //reverse y el video de creditos al final
              FFmpegKit.executeAsync(
                      styleVideoOne,
                      (session) async {
                        final state = FFmpegKitConfig.sessionStateToString(
                            await session.getState());
                        final returnCode = await session.getReturnCode();
                        final failStackTrace =
                            await session.getFailStackTrace();
                        final duration = await session.getDuration();

                        if (ReturnCode.isSuccess(returnCode)) {
                          print(chalk.yellow.bold(
                              "Aplicación de efectos Completa $duration milliseconds. now Show video"));
                          setState(() {
                            isEncoded == true;
                          });
                          videoFile.readAsBytes().then((valueBytes) {
                            print(chalk.yellowBright(valueBytes));
                            print(chalk.yellow(videoFile.path));

/* 
                              Get.offNamed(RouteNames.showVideo,
                                  arguments: [valueBytes, videoFile.path]); */
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
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(chalk.brightGreen(file[1]));
    // print(chalk.brightGreen(file[0]));

    return Scaffold(
      backgroundColor: AppColors.vulcan,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: _opacity,
              child: BackgroundGradient(context)),
          dinamicText(),
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
    int totalVideoDuration = 29000;

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

  dinamicText() {
    if (isEncoded == false && completePercentage < 100) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            backgroundColor: AppColors.violet,
            color: AppColors.royalBlue,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            " Procesando video $completePercentage % ",
            style: TextStyle(fontSize: sclW(context) * 3),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Procesamiento completo...\n\n" + "Disfruta tu experiencia.",
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
                  return ElevatedButton(
                      child: const Text("Ver Video"),
                      onPressed: () {
                        fileEncoded.readAsBytes().then((valueBytes) =>
                            Get.offNamed(RouteNames.showVideo,
                                arguments: [valueBytes, fileEncoded.path]));
                        print(chalk.white.bold(fileEncoded.path));
                      });
                } else {
                  return Container();
                }
              }),
        ],
      );
    }
  }
}
