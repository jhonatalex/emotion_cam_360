import 'package:emotion_cam_360/ui/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_names.dart';
import '../../widgets/drawer.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        color: Color(0xff141220),
        child: Column(
          children: [
            MyAppBar('MENU'),
            Text('Hola Mundo'),
            ElevatedButton(
                onPressed: () {
                  Get.offNamed(RouteNames.home);
                },
                child: Text('Volver'))
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
