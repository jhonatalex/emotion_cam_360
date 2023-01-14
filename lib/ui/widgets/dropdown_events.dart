import 'package:chalkdart/chalk.dart';
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DropdownEventos extends StatefulWidget {
  List listEvents = [];

  DropdownEventos(this.listEvents, {super.key});

  @override
  State<DropdownEventos> createState() => _DropdownEventosState(listEvents);
}

class _DropdownEventosState extends State<DropdownEventos> {
  // Initial Selected Value
  List listEvents = [];

  EventEntity dropdownvalue = const EventEntity(
      "Seleccione", "Seleccione", "music",
      overlay: "overlay");

  _DropdownEventosState(this.listEvents);

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventoActualPreferencesProvider>(context);

    var listEventEntity = [];

    listEventEntity.add(const EventEntity("Seleccione", "Seleccione", "music",
        overlay: "overlay"));

    listEventEntity.add(const EventEntity(
        "Crear Evento", "Crear Evento", "music",
        overlay: "overlay"));

    if (eventProvider.eventPrefrerences != null) {
      listEventEntity.add(eventProvider.eventPrefrerences);
    }

    //CONVERTIR RESPUESTA EN ENTITIES
    /*  for (var doc in listEvents) {
      EventEntity eventNew = EventEntity(doc["id"], doc["name"], doc["music"],
          overlay: doc["overlay"], videos: doc["videos"]);

      listEventEntity.add(eventNew);
    } */

    return DropdownButton(
      // Initial Value
      value: dropdownvalue,
      dropdownColor: AppColors.vulcan,
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: listEventEntity.map<DropdownMenuItem<EventEntity>>((value) {
        return DropdownMenuItem<EventEntity>(
          value: value,
          child: Text(
            value.name,
            style: TextStyle(fontSize: sclH(context) * 3),
          ),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (EventEntity? newValue) {
        setState(() {
          dropdownvalue = newValue!;

          if (newValue.name == "Crear Evento") {
            Get.offNamed(RouteNames.eventPage);
          }

          //eventProvider.saveEventPrefrerence(newValue);
        });
      },
    );
  }
}
