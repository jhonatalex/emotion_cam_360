import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:flutter/material.dart';

bool _throwShotAway = true;
var isSelected = [true, true, true];
var _giveVerse = true;
var _duelCommandment = 5;

class SettingsVideo extends StatefulWidget {
  const SettingsVideo({super.key});

  @override
  State<SettingsVideo> createState() => _SettingsVideoState();
}

class _SettingsVideoState extends State<SettingsVideo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sclW(context) * 100,
      padding: EdgeInsets.symmetric(
        horizontal: sclW(context) * 5,
      ),
      child: ListView(
        children: [
          const Text(
            "Ajustes de Video",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 50),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Container(
                width: sclW(context) * 40,
                child: const Text(
                  "Configuración rápida:",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(width: sclW(context) * 50, child: MenuEvento()),
            ],
          ),
          SwitchListTile(
            activeTrackColor: AppColors.royalBlue,
            activeColor: AppColors.violet,
            title: const Text(
              'Logo Predeterminado',
            ),
            subtitle: const Text(
              "Deside si Usar el logo Emotion cam 360",
            ),
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
            title: const Text(
              'Música',
            ),
            subtitle: const Text(
              "Deside que música usar de fondo para el video",
            ),
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
            title: const Text(
              'Tiempo de grabación:',
            ),
            subtitle: const Text(
              "Duración del video en segundos",
            ),
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
            title: const Text(
              'Auto fade in/out ',
            ),
            subtitle: const Text(
              "Aplica un efecto aclarando al inicio y oscureciendo al final",
            ),
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
            title: const Text(
              'No guardar en el dispositivo',
            ),
            subtitle: const Text(
              "Borrar video despues de renderizarlo y subirlo a la nube",
            ),
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
            title: const Text(
              'Reproducir Video al finalizar',
            ),
            subtitle: const Text(
              "En la pantalla final carga una vista previa del video capturado",
            ),
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
          const Text(
            "Recorte de video:",
            style: TextStyle(fontSize: 30),
          ),
          Table(
            children: [
              TableRow(children: [
                const Text(
                  "1x1 :",
                  style: TextStyle(fontSize: 30),
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
                    const Text(
                      "1080*1080",
                      style: TextStyle(fontSize: 30),
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
                    const Text(
                      "720*720",
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ]),
              TableRow(children: [
                const Text(
                  "16x9 :",
                  style: TextStyle(fontSize: 30),
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
                    const Text(
                      "1920*1080",
                      style: TextStyle(fontSize: 30),
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
                    const Text(
                      "1280 * 720",
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ]),
            ],
          ),
          Divider(
            height: 30,
            color: AppColors.violet,
            indent: 20,
            endIndent: 20,
            thickness: 2,
          ),
          Text(
            "Linea de tiempo ",
            style: TextStyle(fontSize: 30),
          ),
          Container(
            width: double.infinity,
            height: 300,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemExtent: 60,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: _duelCommandment.toDouble(),
                      min: 1.0,
                      max: 10.0,
                      divisions: 10,
                      label: '$_duelCommandment',
                      onChanged: (double newValue) {
                        setState(() {
                          _duelCommandment = newValue.round();
                        });
                      },
                    ),
                  );
                }),
          ),
          SwitchListTile(
            activeTrackColor: AppColors.royalBlue,
            activeColor: AppColors.violet,
            title: const Text(
              'Boomerang',
            ),
            subtitle: const Text(
              "Al terminar la linea de tiempo continúa en sentido inverso",
            ),
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

class MenuEvento extends StatelessWidget {
  const MenuEvento({super.key});

  @override
  Widget build(BuildContext context) {
    var _simpleValue = 0;
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      initialValue: _simpleValue,
      color: AppColors.vulcan,
      onSelected: (value) => showAndSetMenuSelection(context, value),
      itemBuilder: (context) => <PopupMenuItem>[
        PopupMenuItem(
          value: 1,
          child: Text(
            "Predeterminado",
            style: TextStyle(fontSize: 30),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            "Alegría ritmica",
            style: TextStyle(fontSize: 30),
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Text(
            "Enamorados",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ],
      child: ListTile(
        title: Text("Predeterminado"),
        subtitle: Text("Selecciona otra configuración"),
      ),
    );
  }
}

showAndSetMenuSelection(BuildContext context, value) {}