import 'dart:core';

import 'package:chalkdart/chalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emotion_cam_360/controllers/auth_controller.dart';
import 'package:emotion_cam_360/repositories/abstractas/my_user_repository.dart';
import 'package:emotion_cam_360/repositories/implementations/my_user_repository.dart';
import 'package:emotion_cam_360/servicies/auth_service.dart';
import 'package:emotion_cam_360/ui/pages/suscripcion/subscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../entities/user.dart';
import '../abstractas/auth_repositoryAbst.dart';

class AuthRepositoryImp implements AuthRepository {
  //const AuthFirebase();

  final _firebaseAuthUniqueInstance = FirebaseAuth.instance;
  final _userRepository = Get.put<MyUserRepository>(MyUserRepositoryImp());
  FirebaseAuth auth = FirebaseAuth.instance;

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  AuthClass authClass = AuthClass();

  //FUNCION PARA CONVERTIR USER DE FIREBASE  DE NUESTROO USER MODELO AUTHUSER
  AuthUser? _userFirebaseConvertToModel(User? user) =>
      user == null ? null : AuthUser(user.uid);

  //CONVERTIR EL USUARIO ACTUAL DE FIREBASE EN NUESTRO USER DE MODELO
  @override
  AuthUser? get authUser =>
      _userFirebaseConvertToModel(_firebaseAuthUniqueInstance.currentUser);

  //FUNCION QUE CREA UN SUBSCRIPCION A FIREBASE Y CADA VEZ QUE CAMBIE EL ESTADO LLMA FUNCION DE NUESTRO USUARIO
  @override
  Stream<AuthUser?> get onAuthStateChanged => _firebaseAuthUniqueInstance
      .authStateChanges()
      .asyncMap(_userFirebaseConvertToModel);

  //EMAIL PASSWORD
  @override
  Future<AuthUser?> signInWithEmailAndPassword(
      String username, String password) async {
    final authResult = await _firebaseAuthUniqueInstance
        .signInWithEmailAndPassword(email: username, password: password);

    return _userFirebaseConvertToModel(authResult.user);
  }

  //CREAR USUARIO CON EMAIL
  @override
  Future<AuthUser?> createUserWithEmail(
      String username, String password) async {
    /*    final authResult = await _firebaseAuthUniqueInstance
        .createUserWithEmailAndPassword(email: username, password: password);
 */
    firebase_auth.UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: username, password: password);

    //PERSITENCIA DATA
    await authClass.storeTokenAndData(userCredential);

    print(chalk.green.bold(userCredential));

    //GUARDAR EL USUARIO PERSONALIZADO
    final uid = Get.find<AuthController>().authUser.value?.uid;

    final email = username;
    //const statusInitial = true;
    DateTime dateInitial2 = newDateLimit(15);
    Timestamp dateInitial = Timestamp.fromDate(dateInitial2);

    final newUser = MyUser(uid!, email, userCredential.user!.emailVerified,
        date: dateInitial);

    await _userRepository.saveMyUser(newUser);

    //ENVIA EL EMAIL PARA VERIFICARLO
    //await FirebaseAuth.instance.setLanguageCode("es");
    await userCredential.user?.sendEmailVerification();

    return _userFirebaseConvertToModel(userCredential.user);
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  //-----------------------------GOOGLE----------------------------------------------------------------------------
  @override
  Future<AuthUser?> signInGoogle() async {
    //   final googleUser = await GoogleSignIn().signIn();
    // final googleAuth = await googleUser?.authentication;

    //final googleSignInAccount = await GoogleSignIn().signIn();

    print(chalk.white.bold("Entra en login"));
    try {
      final googleSignInAccount = await _googleSignIn.signIn();

      //print(chalk.green.bold(googleSignInAccount));

      final googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      //print(chalk.yellow.bold(googleSignInAuthentication));

      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      print(chalk.green.bold(userCredential));

      if (userCredential.additionalUserInfo!.isNewUser) {
        //GUARDAR EL USUARIO PERSONALIZADO
        final uid = userCredential.user?.email;
        final email = userCredential.user?.email;
        //const statusInitial = true;
        DateTime dateInitial2 = newDateLimit(15);
        Timestamp dateInitial = Timestamp.fromDate(dateInitial2);

        final newUser = MyUser(uid!, email!, userCredential.user!.emailVerified,
            date: dateInitial);
        await _userRepository.saveMyUser(newUser);
      }

      //PERSITENCIA DATA
      await authClass.storeTokenAndData(userCredential);

      return _userFirebaseConvertToModel(userCredential.user);
    } catch (e) {
      print(chalk.yellow.bold(e.toString()));
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    //final googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
    await _firebaseAuthUniqueInstance.signOut();
  }

  @override
  Future<void> forgotPasswordWithEmail(final String username) {
    return _firebaseAuthUniqueInstance.sendPasswordResetEmail(email: username);
  }
}
