import 'dart:async';

import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/ui/widgets/subscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final Rx<AuthUser?> authUser = Rx(null);

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
    if (user == null) {
      authState.value = AuthState.signedOUT;
      Get.offAllNamed(RouteNames.signIn);
      //Get.offAllNamed(RouteNames.home);
    } else {
      //authState.value = AuthState.signedIN;
      //Get.offAllNamed(RouteNames.signIn);
      //Get.offAllNamed(RouteNames.home);
      print(chalk.green.bold("usuario: $user"));
      int _diasRestantes = diasRestantes();
      print(chalk.green.bold("calculo de dias restantes"));
      _authSubscriptionChanged(_diasRestantes);
      print(chalk.green.bold("paso a authsubscription"));
    }
    authUser.value = user;
  }

  void _authSubscriptionChanged(int diasRestantes) {
    //VERIFICA LOS DIAS RESTANTES PARA MANDARLO A LA PANTALLA CORRECTA Y SET THE STATE
    print(chalk.green.bold("DÍAS RESTANTES: $diasRestantes"));
    if (diasRestantes < 0) {
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
