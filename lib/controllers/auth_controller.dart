import 'dart:async';
import 'package:emotion_cam_360/ui/pages/suscripcion/subscription.dart';
import 'package:get/get.dart';

import '../repositories/abstractas/auth_repositoryAbst.dart';
import '../ui/routes/route_names.dart';

enum AuthState {
  signedOUT,
  signedIN,
}

class AuthController extends GetxController {
  //final Rx<AuthUser?> authUser = Rx(null);

  final _authRepository = Get.find<AuthRepository>();
  late StreamSubscription _authSubscription;

  final Rx<AuthState> authState = Rx(AuthState.signedOUT);
  Rx<AuthUser?> authUser = Rx(null);

  @override
  void onInit() async {
    // Just for testing. Allows the splash screen to be shown a few seconds
    //await Future.delayed(const Duration(seconds: 3));
    _authSubscription =
        _authRepository.onAuthStateChanged.listen(_authStateChanged);
    // await getDateSaved;

    super.onInit();
  }

  void _authStateChanged(AuthUser? user) async {
    //VERIFICA EL USUARIO NO EXISTE PARA MANDARLO A LOGUEARSE Y SET THE STATE

    //print(chalk.bgRed.bold('entro al Controller Auth', user));
    // CAMBIE DE PSOSICION ESTBA AL FINAL
    authUser.value = user;
    //print(chalk.redBright.bold('entro al Controller Auth', authUser));

    /*ACTUALIZAR ESTA VARIABLE*/
    bool isFirst = true;
    if (user == null) {
      authState.value = AuthState.signedOUT;
      isFirst
          ? Get.offAllNamed(RouteNames.introductionPage)
          : Get.offAllNamed(RouteNames.signIn);
      //Get.offAllNamed(RouteNames.home);
    } else {
      //authState.value = AuthState.signedIN;
      //Get.offAllNamed(RouteNames.signIn);
      //Get.offAllNamed(RouteNames.home);
      int nDiasRestantes = await diasRestantes();
      _authSubscriptionChanged(nDiasRestantes);
    }
  }

  void _authSubscriptionChanged(diasRestantes) async {
    //VERIFICA LOS DIAS RESTANTES PARA MANDARLO A LA PANTALLA CORRECTA Y SET THE STATE
    if (diasRestantes <= 0) {
      authState.value = AuthState.signedOUT;
      Get.offAllNamed(RouteNames.subscription);
      //Get.offAllNamed(RouteNames.home);
    } else {
      authState.value = AuthState.signedIN;
      //Get.offAllNamed(RouteNames.signIn);
      Get.offAllNamed(RouteNames.home);
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  @override
  void onClose() {
    _authSubscription.cancel();
    super.onClose();
  }
}
