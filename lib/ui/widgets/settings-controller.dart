import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxBool fadeInOut = true.obs;
  RxBool noSave = true.obs;
  RxInt normal1 = 3.obs;
  RxInt slowMotion = 4.obs;
  RxInt normal2 = 3.obs;
  RxInt reverse = 8.obs;
  RxInt creditos = 8.obs;
  RxInt timeRecord = 10.obs;
  RxInt timeTotal = 29.obs;
  RxInt reverseMax = 0.obs;

  makeDefault() {
    normal1.value = 3;
    slowMotion.value = 4;
    normal2.value = 3;
    reverse.value = 8;
    creditos.value = 8;
    timeRecord.value = 10;
    timeTotal.value = 29;
    reverseMax.value = 0;
  }
}
