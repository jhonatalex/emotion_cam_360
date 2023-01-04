// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:io';

import 'package:chalkdart/chalk.dart';
import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit_config.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class VideoUtil {
  // lista stilos de video

  static const String LOGO = "waterrmark.png";
  static const String INTRO = "intro.mp4";
  static const String ENDING = "ending.mp4";
  static const String VIDEO360 = "video360.mp4";
  static const String MUSIC1 = "hallman-ed.mp3";
  static const String video1 =
      "/data/user/0/com.example.emotion_cam_360/cache/video1.mp4";
  static const String video2 =
      "/data/user/0/com.example.emotion_cam_360/cache/video2.mpg";
  static const String video3 =
      "/data/user/0/com.example.emotion_cam_360/cache/video3.mpg";
  static const String video4 =
      "/data/user/0/com.example.emotion_cam_360/cache/video4.mpg";
  // static const String ASSET_5 = "sld_4.png";
  //static const String VIDEO_CREATED = "1.mp4";
  // static const String SUBTITLE_ASSET = "subtitle.srt";
  //static const String FONT_ASSET_1 = "doppioone_regular.ttf";
  //static const String FONT_ASSET_2 = "truenorg.otf";

  static void prepareAssets() async {
    await assetToFile(LOGO);
    await assetToFile(INTRO);
    await assetToFile(ENDING);
    await assetToFile(VIDEO360);
    await assetToFile(MUSIC1);
    // await assetToFile(ASSET_5);
    // await assetToFile(VIDEO_CREATED);
    // await videoCreateToFile(VIDEO_CREATED);
    //await assetToFile(SUBTITLE_ASSET);
    //await assetToFile(FONT_ASSET_1);
    //await assetToFile(FONT_ASSET_2);
  }

  static Future<File> assetToFile(String assetName) async {
    final ByteData assetByteData =
        await rootBundle.load('assets/img/$assetName');

    final List<int> byteList = assetByteData.buffer
        .asUint8List(assetByteData.offsetInBytes, assetByteData.lengthInBytes);

    final String fullTemporaryPath =
        join((await tempDirectory).path, assetName);

    Future<File> fileFuture = new File(fullTemporaryPath)
        .writeAsBytes(byteList, mode: FileMode.writeOnly, flush: true);

    print(chalk.white
        .bold('assets/img/$assetName saved to file at $fullTemporaryPath.'));

    return fileFuture;
  }

  static Future<String> assetPath(String assetName) async {
    return join((await tempDirectory).path, assetName);
  }

  static Future<Directory> get documentsDirectory async {
    return await getApplicationDocumentsDirectory();
  }

  static Future<Directory> get tempDirectory async {
    return await getTemporaryDirectory();
  }

  //NOTAS DEL CODIGO
  //-SS Inicio de corte -T Duración a partir de ahí
  //map 0:v canal 0 del video se quita -map 0:v se deja -map 1:a que es el nuevo audio
  //-vcodec copy   forzar a copiar el codec del video de entrada
  //"-vf vignette=PI/4  efecto opacidad en los bordes
  //-vf vignette='PI/4+random(1)*PI/50':eval=frame mayor
  //-vf fade=t=in:st=0:d=3,fade=t=out:st=4:d=3 Difuminado st inicio t duración
  //-af afade=t=in:st=0:d=1,afade=t=out:st=7:d=1 Difuminado  de audio st inicio t duración
  //-an  -vn quitar audio o video
  //-vf reverse
  //-vf scale=320:240 -vf scale=320:-1 -vf scale=iw/2:ih/2 video_x.mp4
  //-filter_complex amerge  fusionar pistas de audio
  //-vf setpts=0.02*PTS  CAMBIAR VELOCIDAD 2 lento 1 normal 0.5 rapido
  //-i $logoPath -filter_complex overlay=10:10 MARCA DE AGUA posicionada

  static watermark(
    String logoPath,
    String videoFilePath,
  ) {
    return "-y -i $video2  " +
        "-i $logoPath -filter_complex overlay=610:1170 " +
        videoFilePath;
  }

  static musica(
    String logoPath,
    String music1Path,
    String videoFilePath,
  ) {
    return "-y -i $video1 " +
        "-ss 0 -t 26 -i $music1Path " +
        "-vf fade=t=in:st=0:d=2,fade=t=out:st=25:d=1 " +
        "-af afade=t=in:st=0:d=2,afade=t=out:st=25:d=1 " +
        video2;
  }

  static styleVideoOne(
    String logoPath,
    String introPath,
    String endingPath,
    String video360Path,
    String music1Path,
    String videoFilePath,
    //  String videoCodec,
    // String pixelFormat,
    // String customOptions
  ) {
    const String pad =
        "pad=width=720:height=1280:x=(720-iw)/2:y=(1280-ih)/2:color=#00000000";
    return "-y -i $video360Path " +
        "-ss 2 -t 5 -i $video360Path " +
        "-i $endingPath " +
        // "-i $logoPath " +
        "-filter_complex " +
        "\"[0:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,720/1280),min(iw,720),-1)':h='if(gte(iw/ih,720/1280),-1,min(ih,1280))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,split=2[videocompleto1][videocompleto2];" +
        "[1:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,720/1280),min(iw,720),-1)':h='if(gte(iw/ih,720/1280),-1,min(ih,1280))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1[videorecorte1];" +
        "[2:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,720/1280),min(iw,720),-1)':h='if(gte(iw/ih,720/1280),-1,min(ih,1280))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,split=2[creditos1][creditos2];" +
        // "[3:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,720/1280),min(iw,720),-1)':h='if(gte(iw/ih,720/1280),-1,min(ih,1280))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1[watermark];" +
        "[videocompleto1]$pad,trim=start=0:end=6,setpts=PTS-STARTPTS[part1];" +
        "[videocompleto2]$pad,trim=start=2:end=6,setpts=PTS-STARTPTS,reverse[part2];" +
        "[videorecorte1]$pad,setpts=2*PTS[part3];" +
        "[creditos1]$pad,trim=duration=3,select=lte(n\\,90)[part4];" +
        "[creditos2]$pad,trim=duration=3,select=lte(n\\,90),reverse[part5];" +
        //"[watermark]$pad,trim=duration=3,select=lte(n\\,90),overlay=610:1170[part5];" +
        //"[stream3out2]pad=width=720:height=1280:x=(720-iw)/2:y=(1280-ih)/2:color=#00000000,trim=duration=2,select=lte(n\\,90),reverse[part6];" +
        //"[stream2starting][stream1ending]blend=all_expr='if(gte(X,(W/2)*T/1)*lte(X,W-(W/2)*T/1),B,A)':shortest=1[stream2blended];" +
        //"[stream3starting][stream2ending]blend=all_expr='if(gte(X,(W/2)*T/1)*lte(X,W-(W/2)*T/1),B,A)':shortest=1[stream3blended];" +
        //"[stream1overlaid][stream2blended][stream2overlaid][stream3blended][stream3overlaid]concat=n=5:v=1:a=0,scale=w=720:h=1280,format=" +
        "[part1][part2][part3][part4][part5]concat=n=5:v=1:a=0,scale=w=720:h=1280,format=" +
        "yuv420p" + //  pixelFormat +
        "[video]\"" +
        " -map [video] -vsync 2 -async 1 " +
        // customOptions +
//-c:v libx264 -crf 19 -strict experimental
        "-c:v " +
        "mpeg4" + // videoCodec +
        " -r 30 " +
        video1;
  }
}

void deleteFile(File file) {
  file.exists().then((exists) {
    if (exists) {
      try {
        file.delete();
      } on Exception catch (e, stack) {
        print("Exception thrown inside deleteFile block. $e");
        print(stack);
      }
    }
  });
}
