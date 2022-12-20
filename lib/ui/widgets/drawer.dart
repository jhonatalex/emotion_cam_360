import 'package:flutter/material.dart';

import '../../repositories/abstractas/appcolors.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.vulcan.withOpacity(0.7),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Image.asset(
            "assets/img/logo-emotion.png",
            height: 100,
          ),
          const Text(
            'EMOTION \n CAM 360',
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  //  tileColor: Colors.black38,
                  leading: Icon(
                    Icons.home,
                  ),
                  title: Text('Home'),
                  // onTap: () {},
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(
                    Icons.home,
                  ),
                  title: Text('Home'),
                  // onTap: () {},
                ),
                ListTile(
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  leading: Icon(
                    Icons.home,
                  ),
                  title: Text('Home'),
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
