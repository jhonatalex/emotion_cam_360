import 'package:get/get.dart';

class DesingController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isWithLogo = true.obs;
  RxBool isWithText = true.obs;
  RxInt currentMarco = 1.obs;
  RxList marcos = <String>[
    'marco0.png',
    'marco1.png',
    'marco2.png',
    'marco3.png',
    'marco4.png',
    'marco5.png',
    'marco6.png',
  ].obs;
}
