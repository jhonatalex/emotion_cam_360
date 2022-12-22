import 'package:flutter/material.dart';

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
            height: sclH(context) * 10,
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
                    Icons.home,
                    size: sclH(context) * 3,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(fontSize: sclH(context) * 3),
                  ),
                  // onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
