import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthClass {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      //GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      final googleSignInAccount = await GoogleSignIn().signIn();
      final googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      if (googleSignInAccount != null) {
        // GoogleSignInAuthentication googleSignInAuthentication =
        //  await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication?.idToken,
          accessToken: googleSignInAuthentication?.accessToken,
        );

        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);

          storeTokenAndData(userCredential);

          //final userSession = Provider.of<SesionPreferencerProvider>(context);
          //userSession.saveUser(userCredential.user!.email);
          Get.offNamed(RouteNames.home);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        const snackbar = SnackBar(content: Text("Not Able to sign In "));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<void> storeTokenAndData(UserCredential userCredential) async {
    print(chalk
        .yellowBright('LOG AQUI ${userCredential.user!.email.toString()}'));

    //CUANDO ES CON USUARIO E IMEL NO TIENE TOKEN
    if (userCredential.credential != null) {
      await storage.write(
          key: "token", value: userCredential.credential!.token.toString());
    }
    await storage.write(
        key: "email", value: userCredential.user!.email.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<String?> getEmailToken() async {
    return await storage.read(key: "email");
  }

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, "Verification Completed");
    }

    verificationFailed(FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    }

    // ignore: prefer_function_declarations_over_variables
    PhoneCodeSent codeSent =
        (String verificationID, [int? forceResnedingtoken]) {
      showSnackBar(context, "Verification Code sent on the phone number");
      setData(verificationID);
    };
    codeAutoRetrievalTimeout(String verificationID) {
      showSnackBar(context, "Time out");
    }
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
    } catch (e) {
      await storage.delete(key: "token");
      await storage.delete(key: "user");
    }
  }

  Future<void> signInwithPhoneNumber(
      String verificationId, smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      storeTokenAndData(userCredential);

      final userSession = Provider.of<SesionPreferencerProvider>(context);
      userSession.saveUser(userCredential.user!.phoneNumber);
      Get.offNamed(RouteNames.home);

      showSnackBar(context, "logged Ind");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackbar = SnackBar(content: Text(text.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
