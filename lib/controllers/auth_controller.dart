import 'dart:async';

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
    await Future.delayed(const Duration(seconds: 3));
    _authSubscription =
        _authRepository.onAuthStateChanged.listen(_authStateChanged);
    super.onInit();
  }

  void _authStateChanged(AuthUser? user) {
    //VERIFICA EL USUARIO PARA MANDARLO A LA PANTALLA CORRECTA Y SET THE STATE
    if (user == null) {
      authState.value = AuthState.signedOUT;
      Get.offAllNamed(RouteNames.home);
    } else {
      authState.value = AuthState.signedIN;
      //Get.offAllNamed(RouteNames.signIn);
      Get.offAllNamed(RouteNames.home);
    }
    authUser.value = user;
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
