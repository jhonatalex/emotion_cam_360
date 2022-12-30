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

  static Future<File> videoCreateToFile(String assetName) async {
    final ByteData assetByteData = await rootBundle
        .load('data/user/0/com.example.emotion_cam_360/app_flutter/$assetName');

    final List<int> byteList = assetByteData.buffer
        .asUint8List(assetByteData.offsetInBytes, assetByteData.lengthInBytes);

    final String fullTemporaryPath =
        join((await tempDirectory).path, assetName);

    Future<File> fileFuture = new File(fullTemporaryPath)
        .writeAsBytes(byteList, mode: FileMode.writeOnly, flush: true);

    print(chalk.white.bold(
        '/data/user/0/com.example.emotion_cam_360/app_flutter/$assetName saved to file at $fullTemporaryPath.'));

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
    //NOTAS DEL CODIGO
    //-SS Inicio de corte -T Duración a partir de ahí
    //map 0:v canal 0 del video se quita -map 0:v se deja -map 1:a que es el nuevo audio
    //-vcodec copy   forzar a copiar el codec del video de entrada
    //"-vf vignette=PI/4  efecto opacidad en los bordes
    //-vf vignette='PI/4+random(1)*PI/50':eval=frame mayor
    //-vf fade=t=in:st=0:d=3,fade=t=out:st=4:d=3 Difuminado st inicio t duración
    //-af afade=t=in:st=0:d=1,afade=t=out:st=7:d=1 Difuminado  de audio st inicio t duración
    //-an  -vn quitar audio o video
    //-vf scale=320:240 -vf scale=320:-1 -vf scale=iw/2:ih/2 video_x.mp4
    //-filter_complex amerge  fusionar pistas de audio
    //-vf setpts=0.02*PTS  CAMBIAR VELOCIDAD 2 lento 1 normal 0.5 rapido
    //-i $logoPath -filter_complex overlay=10:10 MARCA DE AGUA posicionada
    return "-i '" +
        introPath +
        "' " +
        "-i \"" +
        video360Path +
        "\" " +
        "-i \"" +
        endingPath +
        "\" " +
        "-filter_complex " +
        "\"[0:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,720/1280),min(iw,720),-1)':h='if(gte(iw/ih,720/1280),-1,min(ih,1280))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,split=2[stream1out1][stream1out2];" +
        "[1:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,720/1280),min(iw,720),-1)':h='if(gte(iw/ih,720/1280),-1,min(ih,1280))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,split=2[stream2out1][stream2out2];" +
        "[2:v]setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,720/1280),min(iw,720),-1)':h='if(gte(iw/ih,720/1280),-1,min(ih,1280))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1,split=2[stream3out1][stream3out2];" +
        "[stream1out1]pad=width=720:height=1280:x=(720-iw)/2:y=(1280-ih)/2:color=#00000000,trim=duration=3,select=lte(n\\,90)[stream1overlaid];" +
        "[stream1out2]pad=width=720:height=1280:x=(720-iw)/2:y=(1280-ih)/2:color=#00000000,trim=duration=1,select=lte(n\\,30)[stream1ending];" +
        "[stream2out1]pad=width=720:height=1280:x=(720-iw)/2:y=(1280-ih)/2:color=#00000000,trim=duration=2,select=lte(n\\,60)[stream2overlaid];" +
        "[stream2out2]pad=width=720:height=1280:x=(720-iw)/2:y=(1280-ih)/2:color=#00000000,trim=duration=1,select=lte(n\\,30),split=2[stream2starting][stream2ending];" +
        "[stream3out1]pad=width=720:height=1280:x=(720-iw)/2:y=(1280-ih)/2:color=#00000000,trim=duration=2,select=lte(n\\,60)[stream3overlaid];" +
        "[stream3out2]pad=width=720:height=1280:x=(720-iw)/2:y=(1280-ih)/2:color=#00000000,trim=duration=1,select=lte(n\\,30)[stream3starting];" +
        "[stream2starting][stream1ending]blend=all_expr='if(gte(X,(W/2)*T/1)*lte(X,W-(W/2)*T/1),B,A)':shortest=1[stream2blended];" +
        "[stream3starting][stream2ending]blend=all_expr='if(gte(X,(W/2)*T/1)*lte(X,W-(W/2)*T/1),B,A)':shortest=1[stream3blended];" +
        "[stream1overlaid][stream2blended][stream2overlaid][stream3blended][stream3overlaid]concat=n=5:v=1:a=0,scale=w=720:h=1280,format=" +
        "yuv420p" + //  pixelFormat +
        "[video]\"" +
        " -map [video] -vsync 2 -async 1 " +
        // customOptions +

        "-c:v " +
        "mpeg4" + // videoCodec +
        " -r 30 " +
        videoFilePath;
  }

  static styleVideoTwo(
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
    return " -i $video360Path -ss 0 -t 8 -i $music1Path " +
        "-i $logoPath -filter_complex overlay=10:10 " +
        "-map 0:v -map 1:a  " +
        //"-vf \"zoompan=z='min(zoom+0.0010,1.5)':d=700:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=720x1080\" " +
        /* " -filter:v 'setpts=0.5*PTS' " + */
        //"-vf vignette=PI/4 " +
        //   "-vf vignette='PI/4+random(1)*PI/50':eval=frame " +
        // "-vf fade=t=in:st=0:d=1,fade=t=out:st=7:d=1 " +
        // "-af afade=t=in:st=0:d=1,afade=t=out:st=7:d=1 " +
        "-b:v 10000k"
            //"-vcodec copy"
            " -r 30 " +
        videoFilePath;
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
