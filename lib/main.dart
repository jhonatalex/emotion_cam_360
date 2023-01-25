import 'package:emotion_cam_360/data/db_data_source.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/repositories/implementations/event_repositoryImple.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/routes/route_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'dependency_injection/app_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //INICIALIZAMOS LA BD E INYECTAMOS LA DEPENDENCIA
  final dbDataSource = await DbDataSource.init();
  final eventRepository = EventRepositoryImple(dbDataSource);
  Get.put(eventRepository);

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //forzar portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => SesionPreferencerProvider()),
          ChangeNotifierProvider(
              create: (context) => VideoPreferencesProvider()),
          ChangeNotifierProvider(
              create: (context) => EventoActualPreferencesProvider()),
        ],
        child: GetMaterialApp(
          theme: ThemeData(
            // Define el Brightness y Colores por defecto
            brightness: Brightness.dark,

            buttonColor: Colors.red,
            colorScheme: const ColorScheme.dark(primary: AppColors.violet),
            primaryColor: AppColors.violet, primaryColorDark: AppColors.violet,

            checkboxTheme: CheckboxThemeData(
                fillColor: MaterialStateProperty.all(AppColors.violet)),

            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(AppColors.royalBlue),
            )),
            outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
              //backgroundColor: MaterialStatePropertyAll<Color>(AppColors.violet),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            )),

            //secondaryHeaderColor: Colors.cyan[600],

            // Define la Familia de fuente por defecto
            fontFamily: 'Raleway',

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
          initialRoute: RouteNames.home,
          getPages: RoutePages.all,
        ));
  }
}
