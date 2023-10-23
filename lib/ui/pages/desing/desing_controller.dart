import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:get/get.dart';

class DesingController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isWithLogo = true.obs;
  //RxBool isWithText = true.obs;
  RxInt currentMarco = 0.obs;
  RxInt positionLogo = 0.obs;
  RxList marcos = <String>[
    'marco0.png',
    'marco1.png',
    'marco2.png',
    'marco3.png',
    'marco4.png',
    'marco5.png',
    'marco6.png',
  ].obs;

  RxInt logoTop = 10.obs;
  RxInt logoLeft = 10.obs;

  logoPositionChange(context) {
    positionLogo.value++;
    if (positionLogo.value > 8) {
      positionLogo.value = 0;
    }
    if (positionLogo.value != 0) {
      isWithLogo.value = true;
      switch (positionLogo.value) {
        case 1:
          logoTop.value = 10;
          logoLeft.value = 10;
          break;
        case 2:
          logoTop.value = 10;
          logoLeft.value = (sclW(context) * 34).round();
          break;
        case 3:
          logoTop.value = 10;
          logoLeft.value = (sclW(context) * 64).round();
          break;
        case 4:
          logoTop.value = (sclH(context) * 35.5).round();
          logoLeft.value = (sclW(context) * 64).round();
          break;
        case 5:
          logoTop.value = (sclH(context) * 71).round();
          logoLeft.value = (sclW(context) * 64).round();
          break;
        case 6:
          logoTop.value = (sclH(context) * 71).round();
          logoLeft.value = (sclW(context) * 34).round();
          break;
        case 7:
          logoTop.value = (sclH(context) * 71).round();
          logoLeft.value = 10;
          break;
        case 8:
          logoTop.value = (sclH(context) * 35.5).round();
          logoLeft.value = 10;
          break;
        default:
      }
    } else {
      isWithLogo.value = false;
    }
    print(chalk.white.bold(positionLogo.value));
  }
}
