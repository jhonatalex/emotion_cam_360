import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/routes/route_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'dependency_injection/app_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        // Define el Brightness y Colores por defecto
        brightness: Brightness.dark,
        primaryColor: AppColors.violet,
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(AppColors.royalBlue),
        )),
        outlinedButtonTheme: const OutlinedButtonThemeData(
            style: ButtonStyle(
          //backgroundColor: MaterialStatePropertyAll<Color>(AppColors.violet),
          foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
        )),

        secondaryHeaderColor: Colors.cyan[600],

        // Define la Familia de fuente por defecto
        fontFamily: 'Montserrat',

        // Define el TextTheme por defecto. Usa esto para espicificar el estilo de texto por defecto
        // para cabeceras, títulos, cuerpos de texto, y más.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          subtitle1: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),

      debugShowCheckedModeBanner: false, //Quitar el banner demo
      initialBinding: const AppBinding(),
      initialRoute: RouteNames.splash,
      getPages: RoutePages.all,
    );
  }
}
