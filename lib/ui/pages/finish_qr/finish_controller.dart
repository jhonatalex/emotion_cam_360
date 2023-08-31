import 'dart:convert';

import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FinishQrController extends GetxController {
  final _evenController = Get.find<EventController>();

  Rx<String?> shortenedUrl = Rx(null);

  @override
  void onInit() async {
    print(chalk.red.bold("Llamando a la api de acortar"));
    shortenedUrl.value = await shortenUrl(_evenController.urlDownload.value);
    print(chalk.red.bold(shortenedUrl.toString()));

    super.onInit();
  }

  Future<String?> shortenUrl(String url) async {
    try {
      final result = await http.post(
          Uri.parse('https://cleanuri.com/api/v1/shorten'),
          body: {'url': url});
      if (result.statusCode == 200) {
        final jsonResult = jsonDecode(result.body);
        return jsonResult['result_url'];
      } else {
        final jsonResult = jsonDecode(result.body);
        print(chalk.white.bold(jsonResult['error']));
      }
      print(result.statusCode.toString());
    } catch (e) {
      print("Error ${e.toString()}");
    }
    return null;
  }
}
