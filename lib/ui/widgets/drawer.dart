import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repositories/abstractas/appcolors.dart';
import '../../repositories/abstractas/responsive.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Text(
            'EMOTION \n CAM 360',
            style: TextStyle(fontSize: sclH(context) * 4, color: Colors.white),
          ),
          SizedBox(
            height: sclH(context) * 3,
          ),
          Padding(
            padding: EdgeInsets.all(sclH(context) * 2),
            child: Column(
              children: [
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  //  tileColor: Colors.black38,
                  leading: Icon(
                    Icons.home,
                    size: sclH(context) * 3,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(fontSize: sclH(context) * 3),
                  ),
                  // onTap: () {},
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(
                    Icons.video_camera_back,
                    size: sclH(context) * 3,
                  ),
                  title: Text(
                    'Finish Qr',
                    style: TextStyle(fontSize: sclH(context) * 3),
                  ),
                  onTap: () {
                    Get.offNamed(RouteNames.finishQr);
                  },
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(
                    Icons.video_camera_back,
                    size: sclH(context) * 3,
                  ),
                  title: Text(
                    'Video Recording',
                    style: TextStyle(fontSize: sclH(context) * 3),
                  ),
                  onTap: () {
                    Get.offNamed(RouteNames.videoProcessing);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Redes Sociales",
                  style: TextStyle(fontSize: sclH(context) * 2),
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
                    Icons.rss_feed,
                    size: sclH(context) * 3,
                  ),
                  title: Text(
                    'RSS',
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
                  "Versión 1.0.0",
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
