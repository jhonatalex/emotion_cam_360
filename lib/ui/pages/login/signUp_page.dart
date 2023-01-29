import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/repositories/abstractas/auth_repositoryAbst.dart';
import 'package:emotion_cam_360/ui/pages/login/signIn_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
        currentPage = HomePage();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Registro",
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              textItem("Email", _emailController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Password", _passwordController, true),
              const SizedBox(
                height: 15,
              ),
              colorButton("Registrarme", userSession),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Tienes una cuenta?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => SignInPage()),
                          (route) => false);
                    },
                    child: const Text(
                      "   Ingresa aqui",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 123, 54, 214),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
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
    } on FirebaseAuthException catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Widget colorButton(String name, SesionPreferencerProvider userSession) {
    return InkWell(
      onTap: () async {
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
            circular = false;
          });
          //VOLATIL DATA
          // userSession.saveUser(userCredential.user!.email);

          //PERSITENCIA DATA
          //authClass.storeTokenAndData(userCredential);

          //print(chalk.brightGreen('LOG AQUI ${userCredential.user!.email}'));

          Get.offNamed(RouteNames.home);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color(0xff604fef),
            Color.fromARGB(255, 153, 120, 230),
            Color(0xff604fef)
          ]),
        ),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
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
