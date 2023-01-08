import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../abstractas/auth_repositoryAbst.dart';

class AuthRepositoryImp implements AuthRepository {
  //const AuthFirebase();

  final _firebaseAuthUniqueInstance = FirebaseAuth.instance;

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
    final authResult = await _firebaseAuthUniqueInstance
        .createUserWithEmailAndPassword(email: username, password: password);

    return _userFirebaseConvertToModel(authResult.user);
  }

  //GOOGLE
  @override
  Future<AuthUser?> signInGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return _userFirebaseConvertToModel(authResult.user);
  }

  @override
  Future<void> signOut() async {
    //final googleSignIn = GoogleSignIn();
    //await googleSignIn.signOut();
    await _firebaseAuthUniqueInstance.signOut();
  }

  @override
  Future<void> forgotPasswordWithEmail(final String username) {
    return _firebaseAuthUniqueInstance.sendPasswordResetEmail(email: username);
  }
}
