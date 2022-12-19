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
        // fontFamily: "Lato", // el tipo de fuente elegida
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        /*textTheme: TextTheme(
             titleMedium: TextStyle(
              fontFamily: "raleway",
              fontSize: 16,
              // fontWeight: FontWeight.bold
            ), 
            titleLarge: TextStyle(
                fontFamily: "raleway",
                fontSize: 18,
                fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(
              fontFamily: "sans",
              fontSize: 13,
            ),
          )*/
      ),

      debugShowCheckedModeBanner: false, //Quitar el banner demo
      initialBinding: const AppBinding(),
      initialRoute: RouteNames.splash,
      getPages: RoutePages.all,
    );
  }
}
