import 'dart:async';
import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/entities/user.dart';
import 'package:emotion_cam_360/ui/pages/suscripcion/subscription.dart';
import 'package:emotion_cam_360/ui/widgets/messenger_snackbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/abstractas/auth_repositoryAbst.dart';
import '../ui/routes/route_names.dart';

enum AuthState {
  signedOUT,
  signedIN,
}

class AuthController extends GetxController {
  final _authRepository = Get.find<AuthRepository>();
  late StreamSubscription _authSubscription;

  final Rx<AuthState> authState = Rx(AuthState.signedOUT);
  Rx<AuthUser?> authUser = Rx(null);

  bool showWelcome = true;

  @override
  void onInit() async {
    _authSubscription =
        _authRepository.onAuthStateChanged.listen(_authStateChanged);
    // await getDateSaved;

    super.onInit();
  }

  void _authStateChanged(AuthUser? user) async {
    //VERIFICA EL USUARIO NO EXISTE PARA MANDARLO A LOGUEARSE Y SET THE STATE
    authUser.value = user;

    final prefs = await SharedPreferences.getInstance();
    final showWelcomePref = prefs.getBool('showWelcomeScreen');

    if (user == null) {
      authState.value = AuthState.signedOUT;

      if (showWelcomePref != null && !showWelcomePref) {
        Get.offAllNamed(RouteNames.signIn);
      } else {
        Get.offAllNamed(RouteNames.introductionPage);
      }
    } else {

        MyUser? user = await getUserCurrent();
        //VALIDAD SI ESTA VERIFCADO
        if(user!.verified){

            int nDiasRestantes = await diasRestantes();
            _authSubscriptionChanged(nDiasRestantes);

        }else{

            authState.value = AuthState.signedOUT;
            Get.offAllNamed(RouteNames.signIn);

        }


    }
  }

  void _authSubscriptionChanged(diasRestantes) async {
    //VERIFICA LOS DIAS RESTANTES PARA MANDARLO A LA PANTALLA CORRECTA Y SET THE STATE
    if (diasRestantes <= 0) {
      authState.value = AuthState.signedOUT;
      Get.offAllNamed(RouteNames.subscription);
    } else {
      authState.value = AuthState.signedIN;
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
