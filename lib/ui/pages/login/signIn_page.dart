// ignore_for_file: must_be_immutable

import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/repositories/abstractas/auth_repositoryAbst.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/background_gradient.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:emotion_cam_360/ui/pages/home/home_page.dart';
import 'package:emotion_cam_360/ui/pages/login/signUp_page.dart';
import 'package:emotion_cam_360/ui/widgets/messenger_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../servicies/auth_service.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool circular = false;
  bool isLogging = false;

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  AuthClass authClass = AuthClass();

  final _authRepository = Get.find<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    final userSession = Provider.of<SesionPreferencerProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xff141221),
          child: Stack(
            children: [
              BackgroundGradient(context),
              SizedBox(
                height: sclH(context) * 50,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: sclH(context) * 5,
                      ),
                      SizedBox(
                          height: sclH(context) * 15,
                          child: Image.asset(
                            "assets/img/logo-emotion.png",
                          )),
                      Text(
                        "Ingresar",
                        style: TextStyle(
                          fontSize: sclH(context) * 5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: sclH(context) * 2,
                      ),
                      buttonItem(
                        "assets/img/google.svg",
                        "Continue con Google",
                        sclH(context) * 4,
                        () async {
                          setState(() {
                            isLogging = true;
                          });
                          try {
                            await _authRepository.signInGoogle();

                            /* GoogleSignIn _googleSignIn = GoogleSignIn(
                              scopes: [
                                'email',
                                'https://www.googleapis.com/auth/contacts.readonly',
                              ],
                            );

                            Future<void> _handleSignIn() async {
                              try {
                                await _googleSignIn.signIn();
                              } catch (error) {
                                print(error);
                              }
                            } */
                          } on FirebaseAuthException catch (e) {
                            /* 
                          final snackbar = SnackBar(content: Text(e.toString()));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar); */
                            MessengerSnackBar(context, e.toString());
                          }

                          //await authClass.googleSignIn(context);
                        },
                      ),
                      /*
                      SizedBox(
                        height: sclH(context) * 2,
                      ),
                      buttonItem("assets/img/phone.svg",
                          "Continue con Teléfono", sclH(context) * 4, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const PhoneAuthPage()));
                      }),*/
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: sclH(context) * 43,
                  left: sclW(context) * 5,
                  right: sclW(context) * 5,
                  bottom: sclH(context) * 3,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: sclW(context) * 5, vertical: sclW(context) * 5),
                decoration: BoxDecoration(
                  color: AppColors.vulcan,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: sclH(context) * 2,
                    ),
                    textItem("Email", _emailController, false),
                    SizedBox(
                      height: sclH(context) * 2,
                    ),
                    textItem("Contraseña", _passwordController, true),
                    SizedBox(
                      height: sclH(context) * 2,
                    ),
                    colorButton("Ingresar", userSession),
                    SizedBox(
                      height: sclH(context) * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "¿No tienes una cuenta? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: sclH(context) * 2,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => const SignUpPage()),
                                (route) => false);
                          },
                          child: Text(
                            "  Registrate",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 123, 54, 214),
                              fontSize: sclH(context) * 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sclH(context) * 2,
                    ),
                    Text(
                      "¿Olvidó su contraseña?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: sclH(context) * 2,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: isLogging
                    ? const CircularProgressIndicator(
                        backgroundColor: AppColors.royalBlue,
                      )
                    : Text(
                        "Ingresa tus datos aquí.",
                        style: TextStyle(
                            color: Colors.white, fontSize: sclH(context) * 3),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonItem(
      String imagePath, String buttonName, double size, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        height: sclH(context) * 9,
        child: Card(
          elevation: 8,
          color: AppColors.vulcan,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(
                width: 1,
                color: Colors.grey,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagePath,
                height: size,
                width: size,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                buttonName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(
      String name, TextEditingController controller, bool obsecureText) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: name,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color.fromARGB(255, 90, 0, 194),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget colorButton(String name, SesionPreferencerProvider userSession) {
    return InkWell(
      onTap: () async {
        try {
          setState(() {
            circular = true;
          });
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text);

          //VOLATIL DATA
          userSession.saveUser(userCredential.user!.email);

          //PERSITENCIA DATA
          authClass.storeTokenAndData(userCredential);

          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const HomePage()),
              (route) => false);
        } catch (e) {
          final msg = e.toString();
          setState(() {
            circular = false;
            print(chalk.white.bold(msg));
          });

          if (msg == "[firebase_auth/unknown] Given String is empty or null") {
            MessengerSnackBar(context, "Los campos no pueden ir vacío.");
          }
          if (msg ==
              "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
            MessengerSnackBar(context,
                "La contraseña es invalida o el usuario no tiene una contraseña.");
          }
          if (msg ==
              "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
            MessengerSnackBar(context,
                "No éxiste usuario registrado con el correo por favor regístrese.");
          }
          if (msg ==
              "[firebase_auth/invalid-email] The email address is badly formatted.") {
            MessengerSnackBar(context, "Ingrese un correo válido.");
          }

          if (msg ==
              "[firebase_auth/channel-error] Unable to establish connection on channel.") {
            MessengerSnackBar(
                context, "Hubo un error de conexión o campos vacios.");
          }
          if (msg ==
              "[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.") {
            MessengerSnackBar(context,
                "Se ha producido un error de red (como tiempo de espera, conexión interrumpida o host inalcanzable).");
          }
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            AppColors.royalBlue,
            AppColors.violet,
            AppColors.royalBlue,
          ]),
        ),
        child: Center(
          child: circular
              ? const CircularProgressIndicator(
                  backgroundColor: AppColors.royalBlue,
                )
              : Text(name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
        ),
      ),
    );
  }
}
