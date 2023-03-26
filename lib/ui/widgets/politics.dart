import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:flutter/material.dart';

class PoliticsPage extends StatelessWidget {
  const PoliticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.vulcan,
        appBar: AppBar(
          title: Text(
            "TÉRMINOS Y CONDICIONES",
            style: TextStyle(fontSize: sclW(context) * 5),
          ),
          centerTitle: true,
          backgroundColor: AppColors.violet,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white12)),
                onPressed: () {},
                child: Text(
                  "Compartir",
                  style: TextStyle(
                      fontSize: sclH(context) * 2,
                      //color: AppColors.royalBlue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              padding: const EdgeInsets.all(10),
              color: Colors.white12,
              height: sclH(context) * 65,
              child: ListView(
                children: [
                  Text(
                    "Importante",
                    style: TextStyle(
                        fontSize: sclH(context) * 2.5,
                        color: AppColors.royalBlue,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. heets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\n"),
                  Text(
                    "Importante",
                    style: TextStyle(
                        fontSize: sclH(context) * 2.5,
                        color: AppColors.royalBlue,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                  const Text(
                      "\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                  ListTile(
                    title: Text(
                      "A. iOS Terms & Conditions.",
                      style: TextStyle(
                          fontSize: sclH(context) * 2.5,
                          color: AppColors.royalBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  const Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                ],
              ),
            ),
            const Spacer(),
            Container(
              color: Colors.white12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Rechazar",
                      style: TextStyle(
                          fontSize: sclH(context) * 2.5,
                          color: AppColors.violet,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Aceptar",
                      style: TextStyle(
                          fontSize: sclH(context) * 2.5,
                          color: AppColors.violet,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
