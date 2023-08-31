// ignore_for_file: must_be_immutable
import 'package:emotion_cam_360/dependency_injection/app_binding.dart';
import 'package:emotion_cam_360/entities/event.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DropdownEventos extends StatefulWidget {
  EventEntity? eventBD;

  DropdownEventos(this.eventBD, {super.key});

  @override
  State<DropdownEventos> createState() => _DropdownEventosState(eventBD);
}

class _DropdownEventosState extends State<DropdownEventos> {
  // Initial Selected Value
  EventEntity? eventBD;

  EventEntity dropdownvalue = const EventEntity(
      "Seleccione", "Seleccione", "music",
      overlay: "overlay");

  _DropdownEventosState(this.eventBD);

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventoActualPreferencesProvider>(context);
    // final _evenController = Get.find<EventController>();

    var listEventEntity = [];

    listEventEntity.add(const EventEntity("Seleccione", "Seleccione", "music",
        overlay: "overlay"));

    listEventEntity.add(const EventEntity(
        "Crear Evento", "Crear Evento", "music",
        overlay: "overlay"));

    if (eventBD != null) {
      listEventEntity.add(eventBD);
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
            //evitar que se desborde si el nombre es muy largo
            value.name != "Seleccione" &&
                    value.name != "Crear Evento" &&
                    value.name.toString().length >= 20
                //que no sea seleccione ni crear evento y tenga mas de 20 caracteres
                ? "${value.name.toString().substring(0, 20)}..."
                : value.name,
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

          if (newValue.name != "Seleccione" &&
              newValue.name != "Crear Evento") {
            eventProvider.saveSleccionarPrefrerence(true);

            // _evenController.getMyEventController(newValue.id);
            eventProvider.saveEventPrefrerence(newValue);
          }
        });
      },
    );
  }
}
