import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/repositories/abstractas/auth_repositoryAbst.dart';
import 'package:emotion_cam_360/ui/pages/login/signIn_page.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/background_gradient.dart';
import 'package:emotion_cam_360/ui/widgets/messenger_snackbar.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../servicies/auth_service.dart';
import '../../routes/route_names.dart';
import '../home/home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Widget currentPage = const SignUpPage(
    key: null,
  );
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = const HomePage();
      });
    }
  }

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool circular = false;
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
              child: Stack(children: [
                BackgroundGradient(context),
                Center(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
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
                        "Registro",
                        style: TextStyle(
                          fontSize: sclH(context) * 5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                      horizontal: sclW(context) * 5,
                      vertical: sclW(context) * 5),
                  decoration: BoxDecoration(
                    color: AppColors.vulcan,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: sclH(context) * 7.5,
                      ),
                      textItem("Email", _emailController, false),
                      SizedBox(
                        height: sclH(context) * 2,
                      ),
                      textItem("Password", _passwordController, true),
                      SizedBox(
                        height: sclH(context) * 2,
                      ),
                      colorButton("Registrarme", userSession),
                      SizedBox(
                        height: sclH(context) * 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "¿Ya tienes una cuenta?",
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
                                      builder: (builder) => SignInPage()),
                                  (route) => false);
                            },
                            child: Text(
                              "   Ingresa aqui",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 123, 54, 214),
                                fontSize: sclH(context) * 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: sclH(context) * 30,
                  width: sclW(context) * 100,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Completa el siguiente",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                          Text(
                          "Formulario: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]))),
    );
  }

  Widget buttonItem(
      String imagePath, String buttonName, double size, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          elevation: 8,
          color: Colors.black,
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

  Future<void> saveMyUser(String email, String password) async {
    try {
      await _authRepository.createUserWithEmail(
        email.trim(),
        password,
      );

      setState(() {
        Get.offNamed(RouteNames.signIn);
      });
    } on FirebaseAuthException catch (e) {
      String snackbar;

      switch (e.code) {
        case 'weak-password':
          snackbar = "La contraseña debería tener al menos 6 caracteres.";
          break;

        case 'email-already-in-use':
          snackbar = " El correo está actualmente en uso.";
          break;

        case 'invalid-email':
          snackbar =
              "Formato de correo incorrecto, verifíquelo e intente de nuevo.";
          break;

        default:
          snackbar = e.code;
          break;
      }

      MessengerSnackBar(context, snackbar);
      setState(() {
        circular = false;
      });
/* 
      switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        } */
    }
  }

  Widget colorButton(String name, SesionPreferencerProvider userSession) {
    return InkWell(
      onTap: () async {
        if (_emailController.text != "" && _passwordController.text != "") {
          setState(() {
            circular = true;
          });
          try {
            /*  firebase_auth.UserCredential userCredential =
              await firebaseAuth.createUserWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text); */
            //print(userCredential.user!.email);

            saveMyUser(_emailController.text, _passwordController.text);

            setState(() {
              //circular = false;
            });

            //VOLATIL DATA
            // userSession.saveUser(userCredential.user!.email);

            //PERSITENCIA DATA
            //authClass.storeTokenAndData(userCredential);

            //print(chalk.brightGreen('LOG AQUI ${userCredential.user!.email}'));
          } catch (e) {
            final snackbar = SnackBar(content: Text(e.toString()));
            MessengerSnackBar(context, snackbar);
            setState(() {
              circular = false;
            });
          }
        } else {
          MessengerSnackBar(
              context, "Los campos, Email y Password, no deben estar vacios.");
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
                    fontSize: 16,
                  )),
        ),
      ),
    );
  }
}
