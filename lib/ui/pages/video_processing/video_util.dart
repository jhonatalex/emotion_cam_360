// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:io';

import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/ui/pages/desing/desing_controller.dart';
import 'package:emotion_cam_360/ui/pages/settings/settings-controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//Resolución
const int rH = 1280;
const int rW = 720;
const String pad =
    "pad=width=$rW:height=$rH:x=($rW-iw)/2:y=($rH-ih)/2:color=#0e0c31";
const String resize =
    "setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,$rW/$rH),min(iw,$rW),-1)':h='if(gte(iw/ih,$rW/$rH),-1,min(ih,$rH))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1";

final SettingsController settingsController = Get.put(SettingsController());
final DesingController desingController = Get.put(DesingController());
final EventController eventController = Get.put(EventController());

class VideoUtil {
//final reverseMax =settingsController.reverseMax.value;

  static const String logo = "watermark.png";
  //static const String bgCreditos = "espiral.mov";
  static const String music1 = "hallman-ed.mp3";
  //static String marco = "marco${desingController.currentMarco.value}.png";
  static List logoPosition = <String>[
    "x=W-w-10:y=H-h-10",
    "x=W-w-10:y=H-h-10",
    "x=W-w-10:y=H-h-10",
    "x=W-w-10:y=H-h-10",
    "x=W-w-10:y=H-h-10",
    "x=W-w-10:y=H-h-10",
    "x=W-w-10:y=H-h-10",
    "x=W-w-10:y=H-h-10",
    "x=W-w-10:y=H-h-10",
  ];
  static List videoCredito = <String>[
    "espiral.mp4", //"espiral.mov",
    "letras.mp4",
    "chispas.mp4",
    "neon.mp4",
  ];
  // static const String ASSET_5 = "sld_4.png";
  //static const String VIDEO_CREATED = "1.mp4";
  // static const String SUBTITLE_ASSET = "subtitle.srt";
  //static const String FONT_ASSET_1 = "doppioone_regular.ttf";

  //static const String FONT_ASSET_2 = "truenorg.otf";

  static void prepareAssets() async {
    await assetToFile(logo);
    //await assetToFile(bgCreditos);
    await assetToFile(music1);
    for (var i = 0; i < videoCredito.length; i++) {
      await assetToFile(videoCredito[i]);
    }
    for (var i = 0; i < desingController.marcos.length; i++) {
      await assetToFile(desingController.marcos[i]);
    }
    // await assetToFile(ASSET_5);
    // await assetToFile(VIDEO_CREATED);
    // await videoCreateToFile(VIDEO_CREATED);
    //await assetToFile(SUBTITLE_ASSET);
    //await assetToFile(FONT_ASSET_1);
    //await assetToFile(FONT_ASSET_2);
  }

  static Future<File> assetToFile(String assetName) async {
    final ByteData assetByteData =
        await rootBundle.load('assets/themes/$assetName');

    final List<int> byteList = assetByteData.buffer
        .asUint8List(assetByteData.offsetInBytes, assetByteData.lengthInBytes);

    final String fullTemporaryPath =
        join((await tempDirectory).path, assetName);

    Future<File> fileFuture = File(fullTemporaryPath)
        .writeAsBytes(byteList, mode: FileMode.writeOnly, flush: true);
/* 
    print(chalk.white
        .bold('assets/themes/$assetName saved to file at $fullTemporaryPath.')); */

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

  static styleVideoOne(
    String logoPath,
    String endingPath,
    String video360Path,
    String music1Path,
    String videoFilePath,
    String marcoPath,
    //  String videoCodec,
    // String pixelFormat,
    // String customOptions
  ) {
    String logoPositionSelected =
        logoPosition[desingController.positionLogo.value];
    int normal1 = settingsController.normal1.value.toInt();
    int slowMotion = settingsController.slowMotion.value;
    int normal2 = settingsController.normal2.value;
    int reverse = settingsController.reverse.value;
    int creditos = settingsController.creditos.value;
    int timeRecord = settingsController.timeRecord.value;
    int timeTotal = settingsController.timeTotal.value;
    int nysm =
        settingsController.normal1.value + settingsController.slowMotion.value;
    int trmr =
        settingsController.timeRecord.value - settingsController.reverse.value;
    int cm1 = settingsController.creditos.value - 1;
    int ttm2 = settingsController.timeTotal.value - 2;
    int cp30 = settingsController.creditos.value * 30;
    print(chalk.white.bold("normal1 $normal1"));
    print(chalk.white.bold("Slow motion $slowMotion"));
    print(chalk.white.bold("normal2 $normal2"));
    print(chalk.white.bold("reverse $reverse"));
    print(chalk.white.bold("creditos $creditos"));
    print(chalk.white.bold("timeRecord $timeRecord"));
    print(chalk.white.bold("timeTotal $timeTotal"));
    print(chalk.white.bold("video360path $video360Path"));
    print(chalk.white.bold("logoPath $logoPath"));
    print(chalk.white.bold("Music path $music1Path"));

    print(chalk.white.bold("Logo position:"));
    print(chalk.white.bold(desingController.positionLogo.value));

    return "-y -hide_banner -i $video360Path "
            "-ss $normal1 -t $slowMotion -i $video360Path "
            "-i $video360Path "
            "-i $endingPath "
            "-ss 0 -t ${timeTotal} -i $music1Path " +
        "-i $logoPath " +
        "-i $logoPath " +
        "-i $marcoPath " + // editada
        "-filter_complex " +
        "\"[0:v]$resize,split=2[videocompleto1][videocompleto2];" +
        "[1:v]$resize[videorecorte1];" +
        "[2:v]$resize,split=1[videocompleto3];" + //split=2[videocompleto3][videocompleto4];" +
        "[3:v]$resize[creditos1];" +
        "[4:a]afade=t=in:st=0:d=2,afade=t=out:st=$ttm2:d=2 [music];" +
        "[5:v]scale=100x100,split=4[wm1][wm2][wm3][wm4];" + //split=5[wm1][wm2][wm3][wm4][wm5];
        "[6:v]scale=350x350[wm6];" +
        "[7:v]$resize,split=4[mc1][mc2][mc3][mc4];" + //[mc5]editada scale=200x200
        "[videocompleto1][mc1]overlay=x=W-w:y=H-h[videocompleto11];" +
        "[videorecorte1][mc2]overlay=x=W-w:y=H-h[videorecorte11];" +
        "[videocompleto2][mc3]overlay=x=W-w:y=H-h[videocompleto21];" +
        "[videocompleto3][mc4]overlay=x=W-w:y=H-h[videocompleto31];" +
        //reversa slowmotion
        //"[videocompleto4][mc5]overlay=x=W-w:y=H-h[videocompleto41];" +
        // termina de aplicar logo
        "[videocompleto11][wm1]overlay=$logoPositionSelected,$pad,trim=start=0:end=$normal1,setpts=PTS-STARTPTS,fade=t=in:st=0:d=1[part1];" +
        "[videorecorte11][wm2]overlay=x=W-w-10:y=H-h-10,$pad,setpts=2*PTS[part2];" +
        "[videocompleto21][wm3]overlay=x=W-w-10:y=H-h-10,$pad,trim=start=$nysm:end=$timeRecord,setpts=PTS-STARTPTS[part3];" +
        "[videocompleto31][wm4]overlay=x=W-w-10:y=H-h-10,$pad,trim=start=$trmr:end=$timeRecord,setpts=PTS-STARTPTS,reverse[part4];" +
        //reversa slowmotion
        //"[videocompleto41][wm5]overlay=x=W-w-10:y=H-h-10,$pad,setpts=2*PTS,trim=start=${trmr - .5}:end=$trmr,setpts=PTS-STARTPTS,reverse[part5];" +
        //termina de aplicar marco
        "[creditos1][wm6]overlay=185:465:enable='between(t, 0,$creditos)',fade=t=in:st=0:d=1,$pad,trim=duration=$creditos,select=lte(n\\,$cp30),fade=t=out:st=$cm1:d=1[part6];" +
        "[part1][part2][part3][part4][part6]concat=n=5:v=1:a=0,scale=w=$rW:h=$rH,format=" + //[part5] n=6
        "yuv420p" + //  pixelFormat + x264
        //"yuv420p10le" + //  pixelFormat + x265
        "[video]\"" +
        //"[video];" +
        //"[video]drawtext='fontfile=FreeSans.ttf:text=%{localtime\:%a %b %d %Y}'[o]\"" +
        //"drawtext='fontfile=FreeSans.ttf:text=%{localtime\:%a %b %d %Y}'"+
        " -map '[video]' -map '[music]' " + //sin probar [music]
        //" -map '[o]' -map '[music]' " + //sin probar [music]

        // customOptions +
        //"-c:v " +
        //"mpeg4 " + // videoCodec +
        //"wmv" + // videoCodec +
        //"libx265 " + // videoCodec +
        //"libkvazaar " + // videoCodec +
        "-c:v libx264 " + // -c:a aac -strict -2 -b:a 192k -movflags +faststart " + // videoCodec + -vsync 2 -async 1
        "-threads 4 " +
        //"-c:v libx264 -c:a aac -strict experimental -b:a 192k -movflags +faststart " + // videoCodec + -vsync 2 -async 1
        // "-b:v 8M " + //-minrate 4000k -maxrate 4000k -bufsize 1835k
        "-r 25 " +
        videoFilePath; //video1; //
  }
}

void deleteFile(File file) {
  file.exists().then((exists) {
    if (exists) {
      file.delete();
      /*  try {
        file.delete();
      } on Exception catch (e, stack
      ) {
      } */
    }
  });
}
