// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:io';

import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/ui/widgets/settings-controller.dart';
import 'package:ffmpeg_kit_flutter_video/ffmpeg_kit_config.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

const String pad =
    "pad=width=720:height=1280:x=(720-iw)/2:y=(1280-ih)/2:color=#604fef";
const String resize =
    "setpts=PTS-STARTPTS,scale=w='if(gte(iw/ih,720/1280),min(iw,720),-1)':h='if(gte(iw/ih,720/1280),-1,min(ih,1280))',scale=trunc(iw/2)*2:trunc(ih/2)*2,setsar=sar=1/1";

final SettingsController settingsController = Get.put(SettingsController());

class VideoUtil {
  static int normal1 = settingsController.normal1.value.toInt();
  static int slowMotion = settingsController.slowMotion.value;
  static int normal2 = settingsController.normal2.value;
  static int reverse = settingsController.reverse.value;
  static int creditos = settingsController.creditos.value;
  static int timeRecord = settingsController.timeRecord.value;
  static int timeTotal = settingsController.timeTotal.value;
  static int nysm =
      settingsController.normal1.value + settingsController.slowMotion.value;
  static int trmr =
      settingsController.timeRecord.value - settingsController.reverse.value;
  static int cm1 = settingsController.creditos.value - 1;
  static int ttm2 = settingsController.timeTotal.value - 2;
  static int cp30 = settingsController.creditos.value * 30;
//final reverseMax =settingsController.reverseMax.value;

  static const String LOGO = "watermark.png";
  static const String BGCREDITOS = "espiral.mov";
  static const String MUSIC1 = "hallman-ed.mp3";
  // static const String ASSET_5 = "sld_4.png";
  //static const String VIDEO_CREATED = "1.mp4";
  // static const String SUBTITLE_ASSET = "subtitle.srt";
  //static const String FONT_ASSET_1 = "doppioone_regular.ttf";
  //static const String FONT_ASSET_2 = "truenorg.otf";

  static void prepareAssets() async {
    await assetToFile(LOGO);
    await assetToFile(BGCREDITOS);
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
        await rootBundle.load('assets/themes/$assetName');

    final List<int> byteList = assetByteData.buffer
        .asUint8List(assetByteData.offsetInBytes, assetByteData.lengthInBytes);

    final String fullTemporaryPath =
        join((await tempDirectory).path, assetName);

    Future<File> fileFuture = new File(fullTemporaryPath)
        .writeAsBytes(byteList, mode: FileMode.writeOnly, flush: true);

    print(chalk.white
        .bold('assets/themes/$assetName saved to file at $fullTemporaryPath.'));

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
    //  String videoCodec,
    // String pixelFormat,
    // String customOptions
  ) {
    print(chalk.white.bold("normal1 $normal1"));
    print(chalk.white.bold("Slow motion $slowMotion"));
    print(chalk.white.bold("normal2 $normal2"));
    print(chalk.white.bold("reverse $reverse"));
    print(chalk.white.bold("creditos $creditos"));
    print(chalk.white.bold("timeRecord $timeRecord"));
    print(chalk.white.bold("timeTotal $MUSIC1"));
    return "-y -hide_banner -i $video360Path " +
        "-ss $normal1 -t $slowMotion -i $video360Path " +
        "-i $video360Path " +
        "-i $endingPath " +
        "-ss 0 -t $timeTotal -i $music1Path " +
        "-i $logoPath " +
        "-i $logoPath " +
        "-filter_complex " +
        "\"[0:v]$resize,split=2[videocompleto1][videocompleto2];" +
        "[1:v]$resize[videorecorte1];" +
        "[2:v]$resize[videocompleto3];" +
        "[3:v]$resize[creditos1];" +
        "[4:a]afade=t=in:st=0:d=2,afade=t=out:st=$ttm2:d=2 [music];" +
        "[5:v]scale=100x100,split=4[wm1][wm2][wm3][wm4];" +
        "[6:v]scale=350x350[wm5];" +
        "[videocompleto1][wm1]overlay=x=W-w-10:y=H-h-10,$pad,trim=start=0:end=$normal1,setpts=PTS-STARTPTS,fade=t=in:st=0:d=1[part1];" +
        "[videorecorte1][wm2]overlay=x=W-w-10:y=H-h-10,$pad,setpts=2*PTS[part2];" +
        "[videocompleto2][wm3]overlay=x=W-w-10:y=H-h-10,$pad,trim=start=$nysm:end=$timeRecord,setpts=PTS-STARTPTS[part3];" +
        "[videocompleto3][wm4]overlay=x=W-w-10:y=H-h-10,$pad,trim=start=$trmr:end=$timeRecord,setpts=PTS-STARTPTS,reverse[part4];" +
        "[creditos1][wm5]overlay=185:465:enable='between(t, 0,$creditos)',fade=t=in:st=0:d=1,$pad,trim=duration=$creditos,select=lte(n\\,$cp30),fade=t=out:st=$cm1:d=1[part5];" +
        "[part1][part2][part3][part4][part5]concat=n=5:v=1:a=0,scale=w=720:h=1280,format=" +
        "yuv420p" + //  pixelFormat +
        "[video]\"" +
        " -map [video] -map [music]  -vsync 2 -async 1 " +

        // customOptions +
        "-c:v " +
        "mpeg4 " + // videoCodec +
        "-b:v 10M " +
        "-r 30 " +
        videoFilePath; //video1; //
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
