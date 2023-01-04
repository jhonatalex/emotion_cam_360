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

  final String _selectedCodec = "mpeg4";
  late String extension;
  late Statistics? _statistics;
  int completePercentage = 0;
  late File fileEncoded;
  double _opacity = 0;
  bool isfirst = true;

  @override
  void initState() {
    super.initState();
    FFmpegKitConfig.init().then((_) {
      VideoUtil.prepareAssets();
    });
  }

  @override
  Widget build(BuildContext context) {
    void consultar() {
      // para consultas de comandos
      const String asset1 = "logo-emotion.png";
      const String asset2 = "sld_0.png";
      const String videoCreated = "1.mp4";
      const String ffmpegCommand =
          "-i data/user/0/com.example.emotion_cam_360/cache/$videoCreated";

      FFmpegKit.execute(ffmpegCommand).then((session) async {
        final state =
            FFmpegKitConfig.sessionStateToString(await session.getState());
        final returnCode = await session.getReturnCode();
        final failStackTrace = await session.getFailStackTrace();
        final output = await session.getOutput();
        print(chalk.white.bold(
            "FFmpeg process exited with state $state and rc $returnCode.${notNull(failStackTrace, "\\n")}"));

        print(chalk.white.bold(output));

        appendOutput(output);
        print(failStackTrace);
        /* 
        if (state == SessionState.failed || !ReturnCode.isSuccess(returnCode)) {
          print(chalk.white.bold(
              "$state Command failed. Please check output for the details."));
        } */
      });
    }

    void encodeVideo() {
      VideoUtil.assetPath(VideoUtil.LOGO).then((logoPath) {
        VideoUtil.assetPath(VideoUtil.INTRO).then((introPath) {
          VideoUtil.assetPath(VideoUtil.ENDING).then((endingPath) {
            VideoUtil.assetPath(VideoUtil.VIDEO360).then((video360Path) {
              VideoUtil.assetPath(VideoUtil.MUSIC1).then((music1Path) {
                getVideoFile().then((videoFile) {
                  // IF VIDEO IS PLAYING STOP PLAYBACK

                  final ffmpegCommand = VideoUtil.styleVideoOne(
                    logoPath,
                    introPath,
                    endingPath,
                    video360Path,
                    music1Path,
                    videoFile.path,
                    // videoCodec,
                    //this.getPixelFormat(),
                    //this.getCustomOptions()
                  );
                  final musica = VideoUtil.musica(
                    logoPath,
                    music1Path,
                    videoFile.path,
                  );

                  final watermark = VideoUtil.watermark(
                    logoPath,
                    videoFile.path,
                  );

                  print(chalk.white.bold(
                      "FFmpeg proceso iniciado con los argumentos: *** $ffmpegCommand'."));

                  FFmpegKit.executeAsync(
                          ffmpegCommand,
                          (session) async {
                            final state = FFmpegKitConfig.sessionStateToString(
                                await session.getState());
                            final returnCode = await session.getReturnCode();
                            final failStackTrace =
                                await session.getFailStackTrace();
                            final duration = await session.getDuration();

                            if (ReturnCode.isSuccess(returnCode)) {
                              print(chalk.yellow.bold(
                                  "Aplicación de efectos Completa $duration milliseconds. ahora agregar Música"));
                              isfirst = true;
                              FFmpegKit.executeAsync(
                                      ffmpegCommand,
                                      (session) async {
                                        final state = FFmpegKitConfig
                                            .sessionStateToString(
                                                await session.getState());
                                        final returnCode =
                                            await session.getReturnCode();
                                        final failStackTrace =
                                            await session.getFailStackTrace();
                                        final duration =
                                            await session.getDuration();

                                        if (ReturnCode.isSuccess(returnCode)) {
                                          print(chalk.yellow.bold(
                                              "musica Completo $duration milliseconds; agregar watermark."));
                                          FFmpegKit.executeAsync(
                                                  watermark,
                                                  (session) async {
                                                    final state = FFmpegKitConfig
                                                        .sessionStateToString(
                                                            await session
                                                                .getState());
                                                    final returnCode =
                                                        await session
                                                            .getReturnCode();
                                                    final failStackTrace =
                                                        await session
                                                            .getFailStackTrace();
                                                    final duration =
                                                        await session
                                                            .getDuration();
                                                    isfirst = false;
                                                    if (ReturnCode.isSuccess(
                                                        returnCode)) {
                                                      print(chalk.yellow.bold(
                                                          "Marca de agua Completo $duration milliseconds; show video."));
                                                      fileEncoded
                                                          .readAsBytes()
                                                          .then((valueBytes) =>
                                                              Get.offNamed(
                                                                  RouteNames
                                                                      .showVideo,
                                                                  arguments: [
                                                                    valueBytes,
                                                                    fileEncoded
                                                                        .path
                                                                  ]));
                                                    } else {
                                                      print(chalk.white.bold(
                                                          "musica fallida. Please check log for the details."));
                                                      print(chalk.white.bold(
                                                          "musica with state $state and rc $returnCode.${notNull(failStackTrace, "\\n")}"));
                                                    }
                                                  },
                                                  (log) => print(log.getMessage()),
                                                  (statistics) {
                                                    _statistics = statistics;
                                                    updateProgressDialog();
                                                  })
                                              .then((session) => print(
                                                  chalk.white.bold(
                                                      "Async FFmpeg process started with sessionId ${session.getSessionId()}.")));
                                        } else {
                                          print(chalk.white.bold(
                                              "musica fallida. Please check log for the details."));
                                          print(chalk.white.bold(
                                              "musica with state $state and rc $returnCode.${notNull(failStackTrace, "\\n")}"));
                                        }
                                      },
                                      (log) => print(log.getMessage()),
                                      (statistics) {
                                        _statistics = statistics;
                                        updateProgressDialog();
                                      })
                                  .then((session) => print(chalk.white.bold(
                                      "Async FFmpeg process started with sessionId ${session.getSessionId()}.")));
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
      });
    }

    return Scaffold(
      backgroundColor: AppColors.vulcan,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: _opacity,
              child: BackgroundGradient(context)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              dinamicText(),
              ElevatedButton(
                onPressed: () => encodeVideo(),
                child: const Text(
                  'Generar Video',
                ),
              ),
              FutureBuilder(
                  future: getVideoFile(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      fileEncoded = snapshot.data as File;
                      // print(chalk.white.bold(file));
                      return ElevatedButton(
                          child: const Text("Ver Video"),
                          onPressed: () {
                            fileEncoded.readAsBytes().then((valueBytes) =>
                                Get.offNamed(RouteNames.showVideo,
                                    arguments: [valueBytes, fileEncoded.path]));
                          });
                    } else {
                      return Container();
                    }
                  }),
              // NECESARIO PARA LAS PRUEBAS**********************
              //necesarioParaPruebas(consultar),
            ],
          ),
        ],
      ),
    );
  }

  necesarioParaPruebas(void consultar()) {
    return Expanded(
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () => consultar(),
            child: const Text(
              'Consultar comando',
            ),
          ),
          SingleChildScrollView(reverse: true, child: Text(getOutputText())),
        ],
      ),
    );
  }

  Future<File> getVideoFile() async {
    String videoCodec = _selectedCodec; //"mpeg4";

    String extension;
    switch (videoCodec) {
      case "vp8":
      case "vp9":
        extension = "webm";
        break;
      case "aom":
        extension = "mkv";
        break;
      case "theora":
        extension = "ogv";
        break;
      case "hap":
        extension = "mov";
        break;
      default:
        // mpeg4, x264, x265, xvid, kvazaar
        extension = "mp4";
        break;
    }

    final String video = "video.$extension";
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return File("${documentsDirectory.path}/$video");
  }

  void appendOutput(String? logMessage) {
    if (logMessage != null) {
      _outputText += logMessage;
    }
    setState(() {});
  }

  void updateProgressDialog() {
    var statistics = _statistics;
    if (statistics == null || statistics.getTime() < 0) {
      return;
    }

    int timeInMilliseconds = statistics.getTime();
    int totalVideoDuration = 25000;

    completePercentage = (timeInMilliseconds * 100) ~/ totalVideoDuration;

    if (completePercentage <= 100) {
      if (isfirst = true) {
        setState(() {
          _opacity = completePercentage / 100;
        });
      }
    }
  }

  String _outputText = "";
  String getOutputText() => _outputText;

  dinamicText() {
    if (completePercentage <= 100) {
      return Column(
        children: [
          Text(
            " Procesando video $completePercentage % ",
            style: TextStyle(fontSize: sclW(context) * 3),
          ),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
              "Estamos trabajando en ello...\n\n" +
                  "aplicando los ultimos detalles,\n\n danos un minuto.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: sclW(context) * 3)),
        ],
      );
    }
  }
}
