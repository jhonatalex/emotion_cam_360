import 'dart:io';

//import 'package:emotion_cam_360/ui/pages/video_processing/player.dart';
//import 'package:emotion_cam_360/ui/pages/video_processing/util.dart';
import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_video/return_code.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoProcessingPage extends StatefulWidget {
  const VideoProcessingPage({super.key});

  @override
  State<VideoProcessingPage> createState() => _VideoProcessingPageState();
}

class _VideoProcessingPageState extends State<VideoProcessingPage> {
  VideoPlayerController? _videoPlayerController;
  late var _refreshablePlayerDialogFactory;

  late String _selectedCodec;

  late String extension;
  String ffmpegCommand = "";
  @override
  Widget build(BuildContext context) {
    void encodeVideo() {
      FFmpegKit.executeAsync(
              ffmpegCommand,
              (session) async {
                final state = FFmpegKitConfig.sessionStateToString(
                    await session.getState());
                final returnCode = await session.getReturnCode();
                final failStackTrace = await session.getFailStackTrace();
                final duration = await session.getDuration();

                if (ReturnCode.isSuccess(returnCode)) {
                  print(
                      "Encode completed successfully in ${duration} milliseconds; playing video.");
                  playVideo();
                } else {
                  print("Encode failed. Please check log for the details.");
                  /*   print(
                      "Encode failed with state ${state} and rc ${returnCode}.${notNull(failStackTrace, "\\n")}");
                */
                }
              },
              (log) => print(log.getMessage()),
              (statistics) {
                //this._statistics = statistics;
                // this.updateProgressDialog();
              })
          .then((session) => print(
              "Async FFmpeg process started with sessionId ${session.getSessionId()}."));
    }

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Container(
                width: 200,
                alignment: Alignment.center,
                child: Text(_selectedCodec))),
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: new InkWell(
            onTap: () => encodeVideo(),
            child: new Container(
              width: 100,
              height: 38,
              child: new Center(
                child: new Text(
                  'ENCODE',
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(4.0),
            child: FutureBuilder(
              future: getVideoFile(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  File file = snapshot.data as File;
                  return Container();
                  /*  alignment: Alignment(0.0, 0.0),
                      child:
                          EmbeddedPlayer("${file.path.toString()}", videoTab)); */
                } else {
                  return Container(
                    alignment: Alignment(0.0, 0.0),
                  );
                }
              },
            ),
          ),
        ),
      ],
    ));
  }

  Future<void> playVideo() async {
    if (Platform.isAndroid || Platform.isIOS) {
      if (_videoPlayerController != null) {
        await _videoPlayerController!.initialize();
        await _videoPlayerController!.play();
      }
      _refreshablePlayerDialogFactory.refresh();
    }
  }

  Future<void> pause() async {
    if (Platform.isAndroid || Platform.isIOS) {
      if (_videoPlayerController != null) {
        await _videoPlayerController!.pause();
      }
      _refreshablePlayerDialogFactory.refresh();
    }
  }

  void init(refreshablePlayerDialogFactory) {
    _refreshablePlayerDialogFactory = refreshablePlayerDialogFactory;

    _selectedCodec = "mpeg4";
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

    final String video = "video." + extension;
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return new File("${documentsDirectory.path}/$video");
  }
}
