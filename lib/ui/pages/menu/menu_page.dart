import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repositories/abstractas/appcolors.dart';
import '../../routes/route_names.dart';
import '../../widgets/drawer.dart';
import '../../widgets/image_button.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (() => Get.offNamed(RouteNames.home)),
        ),
      ),
      body: Container(
        color: AppColors.vulcan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ImageButton("assets/img/sld_1.png", 'Estilo 1'),
                ImageButton("assets/img/sld_2.png", 'Estilo 2'),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Get.offNamed(RouteNames.camera);
                },
                child: const Text(
                  'PAGAR',
                  style: TextStyle(fontSize: 50),
                )),
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
