import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:flutter/material.dart';

class DropdownCustom extends StatefulWidget {
  // Initial Selected Value
  String dropdownvalue;

  // List of items in our dropdown menu
  List<String> items;
  DropdownCustom(this.dropdownvalue, this.items);

  @override
  State<DropdownCustom> createState() =>
      _DropdownCustomState(dropdownvalue, items);
}

class _DropdownCustomState extends State<DropdownCustom> {
  // Initial Selected Value
  String dropdownvalue;

  // List of items in our dropdown menu
  List<String> items;
  _DropdownCustomState(this.dropdownvalue, this.items);
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      // Initial Value
      value: dropdownvalue,
      dropdownColor: AppColors.royalBlue,
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(
            items,
            style: TextStyle(fontSize: sclH(context) * 2.5),
          ),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }
}
