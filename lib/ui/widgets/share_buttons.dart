import 'package:flutter/material.dart';

class Sharebuttons extends StatelessWidget {
  const Sharebuttons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.facebook),
          label: const Text("Facebook"),
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.camera_alt_outlined,
            //color: Colors.pink,
          ),
          label: const Text("Instagram"),
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink)),
        ),
        ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.whatsapp_rounded,
              //color: Colors.green,
            ),
            label: const Text("Whatsapp"),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 21, 153, 26)),
            )),
      ],
    );
  }
}
