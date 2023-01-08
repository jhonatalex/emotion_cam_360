import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

//USUARIO DE FIREBASE DONDE VAMOS A RECOGER SOLO EL ID
class AuthUser extends Equatable {
  final String uid;

  const AuthUser(this.uid);

  @override
  List<Object?> get props => [uid];
}

// INTERFACE PARA ABSTRAER EN IMPLEMENTAR EN OTRA CLASE PARA HACER PRUEBAS UNITEST
abstract class AuthRepository {
  AuthUser? get authUser;

  Stream<AuthUser?> get onAuthStateChanged;

  Future<AuthUser?> signInWithEmailAndPassword(
    final String username,
    final String password,
  );

  Future<AuthUser?> createUserWithEmail(
    final String username,
    final String password,
  );

  Future<AuthUser?> signInGoogle();

  Future<void> signOut();

  Future<void> forgotPasswordWithEmail(final String email);
}
