import 'dart:io';

import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesingPage extends StatefulWidget {
  const DesingPage({super.key});

  @override
  State<DesingPage> createState() => _DesingPageState();
}

class _DesingPageState extends State<DesingPage> {
  late String logoPath;
  recursos(context) {
    final eventProvider =
        Provider.of<EventoActualPreferencesProvider>(context, listen: false);
    logoPath = eventProvider.eventPrefrerences.overlay;
  }

  @override
  Widget build(BuildContext context) {
    recursos(context);
    int currentMarco = 1;
    List marcos = <String>[
      '',
      'assets/themes/marco1.png',
      'assets/themes/marco2.png',
      'assets/themes/marco3.png',
      'assets/themes/marco4.png',
    ];
    List logoTop = <int>[];
    List logoleft = <int>[];
    List textTop = <int>[];
    List textleft = <int>[];
    return Container(
      width: sclW(context) * 100,
      height: sclH(context) * 80,
      //margin: EdgeInsets.only(bottom: sclH(context) * 10),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          //*********MARCOS************** */
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              marcos[currentMarco],
              width: sclW(context) * 90,
              height: sclH(context) * 80,
            ),
          ),

          //*********TEXTO *****************/
          Positioned(
            top: sclH(context) * 50 - 200,
            left: sclW(context) * 50 - 100, // textleft[current],
            child: Container(
              width: 200,
              child: TextFormField(
                decoration: const InputDecoration(hintText: "Ingresar texto"),
                //style: TextStyle(backgroundColor: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          //*********LOGO *****************/
          Positioned(
            bottom: 10,
            left: sclW(context) * 5 + 10,
            child: Image.file(
              File(logoPath),
              width: 80, //sclW(context) * 30,
              height: 80, //sclW(context) * 30,
            ),
          ),
          /* 
          FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
          ), */
          Column(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.white,
                ),
                label: Text(
                  "texto",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.white,
                ),
                label: Text(
                  "Logo",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.white,
                ),
                label: Text(
                  "Marco",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
