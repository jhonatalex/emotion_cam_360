// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  String pathImg;
  String text;
  ImageButton(this.pathImg, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: OutlinedButton(
        onPressed: () {},
        child: Column(
          children: [
            Image.asset(
              pathImg,
              height: 200,
              width: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              //style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
