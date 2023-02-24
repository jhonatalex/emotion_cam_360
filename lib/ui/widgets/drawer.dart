import 'package:emotion_cam_360/servicies/auth_service.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/pages/suscripcion/subscription.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appcolors.dart';
import 'responsive.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  AuthClass authClass = AuthClass();

  String? emailUser = '';
  bool actualizado = false;

  late String date;
  int dias = diasRestantes();
  void getEmailCurrentUser() async {
    emailUser = await authClass.getEmailToken();
    if (!emailUser!.isEmpty && actualizado == false) {
      actualizado = true;
      print("Usuario: $emailUser ");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    getEmailCurrentUser();
    return Drawer(
      width: sclW(context) * 80,
      backgroundColor: AppColors.vulcan.withOpacity(0.7),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // const Text("información de Subscripción"),
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                  color: diasRestantes() > 3 ? Colors.green : Colors.orange,
                ),
                onPressed: () {
                  /* 
                  String date = "";
                  String dias = ""; */
                  setState(
                    () {
                      date = formatDatatime(updateDateLimit(0));
                      dias = diasRestantes();
                    },
                  );
                  //dialog con GetX
                  Get.defaultDialog(
                    backgroundColor: AppColors.vulcan,
                    radius: 10.0,
                    contentPadding: const EdgeInsets.all(20.0),
                    title: 'Información de Subscripción',
                    titleStyle: TextStyle(color: AppColors.royalBlue),
                    middleText: 'Fecha de Vencimiento: $date  \n' +
                        'Días Restantes: $dias',
                    middleTextStyle: TextStyle(
                      fontSize: sclH(context) * 3,
                      //color: diasRestantes() > 3 ? Colors.green : Colors.orange,
                    ),
                    textConfirm: 'Okay',
                    confirm: ElevatedButton(
                      onPressed: () => Get.back(),
                      child: const Text(
                        'Aceptar',
                        //style: TextStyle(color: AppColors.violet),
                      ),
                    ),
                    /* cancel: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.cancel),
                          label: Text("cancelar"),
                        ), */
                  );
                },
              ),
            ],
          ),
          Image.asset(
            "assets/img/logo-emotion.png",
            height: sclH(context) * 15,
          ),
          if (emailUser != '')
            Text(
              emailUser == null ? 'EMOTION \n CAM 360' : 'Bienvenido',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: sclH(context) * 3),
            ),
          if (emailUser != '')
            Text(
              emailUser == null ? '' : '$emailUser',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: sclH(context) * 2),
            ),
          Padding(
            padding: EdgeInsets.all(sclH(context) * 2),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(
                    Icons.party_mode_outlined,
                    size: sclH(context) * 3,
                  ),
                  title: Text(
                    'Crear Evento',
                    style: TextStyle(fontSize: sclH(context) * 2.5),
                  ),
                  onTap: () {
                    Get.toNamed(RouteNames.eventPage);
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  //  tileColor: Colors.black38,
                  leading: Icon(
                    emailUser == null
                        ? Icons.bookmark_add_outlined
                        : Icons.bookmark_outlined,
                    size: sclH(context) * 3,
                  ),
                  title: Text(
                    emailUser == null ? 'Subscribirse' : 'Usuario Subscrito',
                    style: TextStyle(fontSize: sclH(context) * 2.5),
                  ),

                  onTap: () {
                    Get.toNamed(RouteNames.subscription);
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  //  tileColor: Colors.black38,
                  leading: Icon(
                    Icons.my_library_books_outlined,
                    size: sclH(context) * 3,
                  ),
                  title: Text(
                    'Terminos y Cond.',
                    style: TextStyle(fontSize: sclH(context) * 2.5),
                  ),

                  onTap: () {
                    Get.toNamed(RouteNames.politics);
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  //  tileColor: Colors.black38,
                  leading: Icon(
                    emailUser == null
                        ? Icons.login_outlined
                        : Icons.logout_outlined,
                    size: sclH(context) * 3,
                  ),
                  title: Text(
                    emailUser == null ? 'Iniciar sesión' : 'Cerrar Sesión',
                    style: TextStyle(fontSize: sclH(context) * 2.5),
                  ),

                  onTap: () async {
                    await authClass.logout();
                    //Get.find<AuthController>().signOut();
                    Get.offAllNamed(RouteNames.signIn);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Redes Sociales",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 123, 54, 214),
                      fontSize: sclH(context) * 2),
                ),
                const Divider(),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(
                    Icons.facebook,
                    size: sclH(context) * 3,
                  ),
                  title: Text(
                    'Facebook',
                    style: TextStyle(fontSize: sclH(context) * 2.5),
                  ),
                  // onTap: () {},
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(
                    Icons.camera_alt_outlined,
                    size: sclH(context) * 3,
                  ),
                  title: Text(
                    'Instagram',
                    style: TextStyle(fontSize: sclH(context) * 2.5),
                  ),
                  // onTap: () {},
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(
                    Icons.play_arrow_rounded,
                    size: sclH(context) * 4,
                  ),
                  title: Text(
                    'Youtube',
                    style: TextStyle(fontSize: sclH(context) * 2.5),
                  ),
                  // onTap: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                Text(
                  "Versión 1.0",
                  style: TextStyle(fontSize: sclH(context) * 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
