import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/widgets/dropdowncustom.dart';
import 'package:flutter/material.dart';

bool _throwShotAway = true;
var isSelected = [true, true, true];
var _giveVerse = true;
var _duelCommandment = 3;

class SettingsVideo extends StatefulWidget {
  const SettingsVideo({super.key});

  @override
  State<SettingsVideo> createState() => _SettingsVideoState();
}

class _SettingsVideoState extends State<SettingsVideo> {
  String configvalue = 'Predeterminado';
  List<String> configitems = [
    "Predeterminado",
    "Alegría ritmica",
    "Enamorados",
  ];
  String musicvalue = 'Hallman E.D.';
  List<String> musicitems = [
    "Hallman E.D.",
    "Titulo Abr1. Autor.",
    "Titulo Abr2. Autor.",
    "Titulo Abr3. Autor.",
  ];
  String timevalue = '10';
  List<String> timeitems = [
    "10",
    "15",
    "20",
  ];
  @override
  Widget build(BuildContext context) {
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
              'Música',
              style: TextStyle(fontSize: sclH(context) * 2.5),
            ),
            subtitle: Text("Deside que música usar de fondo para el video",
                style: TextStyle(fontSize: sclH(context) * 1.7)),
            trailing: DropdownCustom(musicvalue, musicitems),
          ),
          ListTile(
            title: Text(
              'Tiempo de grabación:',
              style: TextStyle(fontSize: sclH(context) * 2.5),
            ),
            subtitle: Text("Duración del video en segundos",
                style: TextStyle(fontSize: sclH(context) * 1.7)),
            trailing: DropdownCustom(timevalue, timeitems),
          ),
          SwitchListTile(
            activeTrackColor: AppColors.royalBlue,
            activeColor: AppColors.violet,
            title: Text(
              'Auto fade in/out ',
              style: TextStyle(fontSize: sclH(context) * 2.5),
            ),
            subtitle: Text(
                "Aplica un efecto aclarando al inicio y oscureciendo al final",
                style: TextStyle(fontSize: sclH(context) * 1.7)),
            value: _throwShotAway,
            onChanged: (bool? newValue) {
              setState(() {
                _throwShotAway = newValue!;
              });
            },
          ),
          SwitchListTile(
            activeTrackColor: AppColors.royalBlue,
            activeColor: AppColors.violet,
            title: Text(
              'No guardar en el dispositivo',
              style: TextStyle(fontSize: sclH(context) * 2.5),
            ),
            subtitle: Text(
                "Borrar video despues de renderizarlo y subirlo a la nube",
                style: TextStyle(fontSize: sclH(context) * 1.7)),
            value: _throwShotAway,
            onChanged: (bool? newValue) {
              setState(() {
                _throwShotAway = newValue!;
              });
            },
          ),
          SwitchListTile(
            activeTrackColor: AppColors.royalBlue,
            activeColor: AppColors.violet,
            title: Text(
              'Reproducir Video al finalizar',
              style: TextStyle(fontSize: sclH(context) * 2.5),
            ),
            subtitle: Text(
                "En la pantalla final carga una vista previa del video capturado",
                style: TextStyle(fontSize: sclH(context) * 1.7)),
            value: _throwShotAway,
            onChanged: (bool? newValue) {
              setState(() {
                _throwShotAway = newValue!;
              });
            },
          ),
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
                    setState(() {
                      _throwShotAway = newValue!;
                    });
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
                    setState(() {
                      _throwShotAway = newValue!;
                    });
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
                    setState(() {
                      _throwShotAway = newValue!;
                    });
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
                    setState(() {
                      _throwShotAway = newValue!;
                    });
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
          Text(
            "Linea de tiempo: ",
            style: TextStyle(fontSize: sclH(context) * 2.5),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("Normal"),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _duelCommandment.toDouble(),
                      min: 0.0,
                      max: 4.0,
                      divisions: 4,
                      label: '$_duelCommandment seg',
                      onChanged: (double newValue) {
                        setState(() {
                          _duelCommandment = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("Slow Motion"),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _duelCommandment.toDouble(),
                      min: 0.0,
                      max: 4.0,
                      divisions: 4,
                      label: '$_duelCommandment seg',
                      onChanged: (double newValue) {
                        setState(() {
                          _duelCommandment = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("Normal"),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _duelCommandment.toDouble(),
                      min: 0.0,
                      max: 4.0,
                      divisions: 4,
                      label: '$_duelCommandment seg',
                      onChanged: (double newValue) {
                        setState(() {
                          _duelCommandment = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("Reverse"),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _duelCommandment.toDouble(),
                      min: 0.0,
                      max: 4.0,
                      divisions: 4,
                      label: '$_duelCommandment seg',
                      onChanged: (double newValue) {
                        setState(() {
                          _duelCommandment = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("Créditos"),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _duelCommandment.toDouble(),
                      min: 0.0,
                      max: 4.0,
                      divisions: 4,
                      label: '$_duelCommandment seg',
                      onChanged: (double newValue) {
                        setState(() {
                          _duelCommandment = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          SwitchListTile(
            activeTrackColor: AppColors.royalBlue,
            activeColor: AppColors.violet,
            title: Text(
              'Boomerang',
              style: TextStyle(fontSize: sclH(context) * 2.5),
            ),
            subtitle: Text(
                "Al terminar la linea de tiempo continúa en sentido inverso",
                style: TextStyle(fontSize: sclH(context) * 1.7)),
            value: _throwShotAway,
            onChanged: (bool? newValue) {
              setState(() {
                _throwShotAway = newValue!;
              });
            },
          ),
          /* ElevatedButton(
              onPressed: () {},
              child: Text(
                "Guardar",
                style: TextStyle(fontSize: sclH(context) * 5),
              )) */
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
/* conexión wifi con gopro
GoPro 7


idioma/lenguaje/lingua
Licencia


10 tramos de 10seg con velocidades
boomeran
*/

class MenuEvento extends StatefulWidget {
  const MenuEvento({super.key});

  @override
  State<MenuEvento> createState() => _MenuEventoState();
}

class _MenuEventoState extends State<MenuEvento> {
  @override
  Widget build(BuildContext context) {
    var _simpleValue = 0;
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      initialValue: _simpleValue,
      color: AppColors.vulcan,
      onSelected: (value) => _simpleValue == value,
      itemBuilder: (context) => <PopupMenuItem>[
        PopupMenuItem(
          value: 1,
          child: Text(
            "Predeterminado",
            style: TextStyle(fontSize: sclH(context) * 2.5),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            "Alegría ritmica",
            style: TextStyle(fontSize: sclH(context) * 2.5),
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Text(
            "Enamorados",
            style: TextStyle(fontSize: sclH(context) * 2.5),
          ),
        ),
      ],
      child: ListTile(
        title: Text(
          "Predeterminado",
          style: TextStyle(fontSize: sclH(context) * 2.5),
        ),
        subtitle: Text("Selecciona otra configuración"),
      ),
    );
  }
}
