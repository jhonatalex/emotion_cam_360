import 'package:emotion_cam_360/controllers/event_controller.dart';
import 'package:emotion_cam_360/servicies/auth_service.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../repositories/abstractas/appcolors.dart';
import '../../repositories/abstractas/responsive.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  AuthClass authClass = AuthClass();

  String? emailUser = '';

  void getEmailCurrentUser() async {
    emailUser = await authClass.getEmailToken();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getEmailCurrentUser();

    return Drawer(
      width: sclW(context) * 80,
      backgroundColor: AppColors.vulcan.withOpacity(0.7),
      child: Column(
        children: [
          SizedBox(
            height: sclH(context) * 10,
          ),
          Image.asset(
            "assets/img/logo-emotion.png",
            height: sclH(context) * 15,
          ),
          SizedBox(
            height: sclH(context) * 2,
          ),
          if (emailUser != '')
            Text(
              emailUser == "" ? 'EMOTION \n CAM 360' : 'Bienvenido',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: sclH(context) * 3),
            ),
          if (emailUser != '')
            Text(
              emailUser == "" ? '' : '$emailUser',
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
                    style: TextStyle(fontSize: sclH(context) * 3),
                  ),
                  onTap: () {
                    Get.offNamed(RouteNames.eventPage);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  //  tileColor: Colors.black38,
                  leading: Icon(
                    emailUser == ""
                        ? Icons.login_outlined
                        : Icons.logout_outlined,
                    size: sclH(context) * 3,
                  ),
                  title: Text(
                    emailUser == "" ? 'Iniciar sesión' : 'Cerrar Sesión',
                    style: TextStyle(fontSize: sclH(context) * 3),
                  ),

                  onTap: () async {
                    await authClass.logout();
                    //Get.find<AuthController>().signOut();
                    Get.offNamed(RouteNames.signIn);
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
                    style: TextStyle(fontSize: sclH(context) * 3),
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
                    style: TextStyle(fontSize: sclH(context) * 3),
                  ),
                  // onTap: () {},
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(
                    Icons.play_arrow_rounded,
                    size: sclH(context) * 3,
                  ),
                  title: Text(
                    'Youtube',
                    style: TextStyle(fontSize: sclH(context) * 3),
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
