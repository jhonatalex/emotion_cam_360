import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:emotion_cam_360/ui/widgets/dropdowncustom.dart';
import 'package:emotion_cam_360/ui/widgets/settings-controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

bool _throwShotAway = true;
var isSelected = [true, true, true];
var _giveVerse = true;

class SettingsVideo extends StatelessWidget {
  const SettingsVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Settings();
  }
}

class Settings extends StatelessWidget {
  final SettingsController settingsController = Get.put(SettingsController());
  String configvalue = 'Predeterminado';
  List<String> configitems = [
    "Predeterminado",
    "Alegría ritmica",
    "Enamorados",
  ];
  String fondovalue = 'Espiral';
  List<String> fondoitems = [
    "Espiral",
    "Explosión", //Titulo Abreviación. Autor.
    "Titulo2 A.A.", //Titulo Abreviación. Autor.
    "Titulo3 A.A.", //Titulo Abreviación. Autor.
  ];

  @override
  Widget build(BuildContext context) {
    print(chalk.white.bold("info"));
    return Container(
      width: sclW(context) * 100,
      padding: EdgeInsets.symmetric(
        horizontal: sclW(context) * 5,
      ),
      child: ListView(
        children: [
          Text(
            "Ajustes de Video",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: sclH(context) * 4,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: sclW(context) * 90,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Configuración rápida: ",
                  style: TextStyle(fontSize: sclH(context) * 2.5),
                ),
                DropdownCustom(configvalue, configitems),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Fondo para créditos',
              style: TextStyle(fontSize: sclH(context) * 2.5),
            ),
            subtitle: Text("Deside que video de fondo usar para los créditos",
                style: TextStyle(fontSize: sclH(context) * 1.7)),
            trailing: DropdownCustom(fondovalue, fondoitems),
          ),
          Obx(() {
            return SwitchListTile(
              activeTrackColor: AppColors.royalBlue,
              activeColor: AppColors.violet,
              title: Text(
                'Auto fade in/out ',
                style: TextStyle(fontSize: sclH(context) * 2.5),
              ),
              subtitle: Text(
                  "Aplica un efecto aclarando al inicio y oscureciendo al final",
                  style: TextStyle(fontSize: sclH(context) * 1.7)),
              value: settingsController.fadeInOut.value,
              onChanged: (bool? newValue) {
                settingsController.fadeInOut.value = newValue!;
              },
            );
          }),
          Obx(() {
            return SwitchListTile(
              activeTrackColor: AppColors.royalBlue,
              activeColor: AppColors.violet,
              title: Text(
                'No guardar en el dispositivo',
                style: TextStyle(fontSize: sclH(context) * 2.5),
              ),
              subtitle: Text(
                  "Borrar video despues de renderizarlo y subirlo a la nube",
                  style: TextStyle(fontSize: sclH(context) * 1.7)),
              value: settingsController.noSave.value,
              onChanged: (bool? newValue) {
                settingsController.noSave.value = newValue!;
              },
            );
          }),
          Divider(
            height: 30,
            color: AppColors.violet,
            indent: 20,
            endIndent: 20,
            thickness: 2,
          ),
          Text("Recorte de video:",
              style: TextStyle(
                fontSize: sclH(context) * 2.5,
              )),
          Row(children: [
            Text(
              "1x1 :",
              style: TextStyle(fontSize: sclH(context) * 2),
            ),
            Row(
              children: [
                Checkbox(
                  value: _throwShotAway,
                  onChanged: (bool? newValue) {
                    _throwShotAway = newValue!;
                  },
                ),
                Text(
                  "1080*1080",
                  style: TextStyle(fontSize: sclH(context) * 2),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _throwShotAway,
                  onChanged: (bool? newValue) {
                    _throwShotAway = newValue!;
                  },
                ),
                Text(
                  "720*720",
                  style: TextStyle(fontSize: sclH(context) * 2),
                ),
              ],
            ),
          ]),
          Row(children: [
            Text(
              "16x9 :",
              style: TextStyle(fontSize: sclH(context) * 2),
            ),
            Row(
              children: [
                Checkbox(
                  value: _throwShotAway,
                  onChanged: (bool? newValue) {
                    _throwShotAway = newValue!;
                  },
                ),
                Text(
                  "1920*1080",
                  style: TextStyle(fontSize: sclH(context) * 2),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _throwShotAway,
                  onChanged: (bool? newValue) {
                    _throwShotAway = newValue!;
                  },
                ),
                Text(
                  "1280 * 720",
                  style: TextStyle(fontSize: sclH(context) * 2),
                ),
              ],
            ),
          ]),
          Divider(
            height: 30,
            color: AppColors.violet,
            indent: 20,
            endIndent: 20,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Linea de tiempo:",
                style: TextStyle(fontSize: sclH(context) * 2.5),
              ),
              TextButton.icon(
                  onPressed: () => settingsController.makeDefault(),
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  label: Text(
                    "default",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: sclW(context) * 100,
            height: 215,
            child: ListView(
              scrollDirection: Axis.horizontal,
              itemExtent: 100,
              children: [
                Obx(() {
                  return Column(
                    children: [
                      Text("Normal"),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          value: settingsController.normal1.value.toDouble(),
                          min: 1.0,
                          max: 4.0,
                          divisions: 3,
                          label: '${settingsController.normal1.value} seg',
                          onChanged: (double newValue) {
                            settingsController.normal1.value = newValue.round();
                            timeRecord();
                          },
                        ),
                      ),
                    ],
                  );
                }),
                Obx(() {
                  return Column(
                    children: [
                      Text("Slow Motion"),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          value: settingsController.slowMotion.value.toDouble(),
                          min: 1.0,
                          max: 4.0,
                          divisions: 3,
                          label: '${settingsController.slowMotion.value} seg',
                          onChanged: (double newValue) {
                            settingsController.slowMotion.value =
                                newValue.round();
                            timeRecord();
                          },
                        ),
                      ),
                    ],
                  );
                }),
                Obx(() {
                  return Column(
                    children: [
                      Text("Normal"),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          value: settingsController.normal2.value.toDouble(),
                          min: 1.0,
                          max: 4.0,
                          divisions: 3,
                          label: '${settingsController.normal2.value} seg',
                          onChanged: (double newValue) {
                            settingsController.normal2.value = newValue.round();
                            timeRecord();
                          },
                        ),
                      ),
                    ],
                  );
                }),
                Obx(() {
                  return Column(
                    children: [
                      Text("Reverse"),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          value: settingsController.reverse.value.toDouble(),
                          min: 1.0,
                          max: reverseMax(),
                          divisions: settingsController.reverseMax.value,
                          label: '${settingsController.reverse.value} seg',
                          onChanged: (double newValue) {
                            settingsController.reverseMax.value =
                                settingsController.timeRecord.value;
                            settingsController.reverse.value = newValue.round();
                            timeRecord();
                          },
                        ),
                      ),
                    ],
                  );
                }),
                Obx(() {
                  return Column(
                    children: [
                      Text("Créditos"),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          value: settingsController.creditos.value.toDouble(),
                          min: 1.0,
                          max: 8.0,
                          divisions: 8,
                          label: '${settingsController.creditos.value} seg',
                          onChanged: (double newValue) {
                            settingsController.creditos.value =
                                newValue.round();
                            timeRecord();
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          Obx(() {
            return Text(
              'Tiempo de grabación: ${settingsController.timeRecord.value.toString()} seg\n' +
                  'Duración del video generado: ${settingsController.timeTotal.value.toString()} seg',
              style: TextStyle(fontSize: sclH(context) * 2.5),
            );
          }),
          /* 
          Obx(() {
            return Text(
              timeTotal(),
              style: TextStyle(fontSize: sclH(context) * 2.5),
            );
          }), */
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  reverseMax() {
    if (settingsController.reverse.value >=
        settingsController.timeRecord.value) {
      settingsController.reverse.value = 1;
    }
    settingsController.reverseMax.value = settingsController.timeRecord.value;
    return settingsController.reverseMax.value.toDouble();
  }

  timeRecord() {
    settingsController.timeRecord.value = settingsController.normal1.value +
        settingsController.slowMotion.value +
        settingsController.normal2.value;

    settingsController.timeTotal.value = settingsController.normal1.value +
        settingsController.slowMotion.value * 2 +
        settingsController.normal2.value +
        settingsController.reverse.value +
        settingsController.creditos.value;
  }

  timeTotal() {
    settingsController.timeTotal.value = settingsController.normal1.value +
        settingsController.slowMotion.value * 2 +
        settingsController.normal2.value +
        settingsController.reverse.value +
        settingsController.creditos.value;
    return 'Duración del video generado: ${settingsController.timeTotal.value.toString()} seg';
  }
}

/* conexión wifi con gopro
GoPro 7


idioma/lenguaje/lingua
Licencia


10 tramos de 10seg con velocidades
boomeran
*/
