// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../repositories/abstractas/responsive.dart';

class ImageButton extends StatefulWidget {
  String pathImg;
  String text;

  int current;
  ImageButton({
    Key? key,
    required this.pathImg,
    required this.text,
    required this.current,
  })  : _current = current,
        super(key: key);

  final int _current;

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(sclH(context) * 3),
      child: OutlinedButton(
        onPressed: () {},
        child: Column(
          children: [
            Image.asset(
              widget.pathImg,
              height: sclH(context) * 25,
              width: sclH(context) * 17.5,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: sclH(context) * 2,
            ),
            Text(
              widget.text,
              style: TextStyle(color: Colors.red, fontSize: sclH(context) * 2),
            ),
            SizedBox(
              height: sclH(context) * 2,
            )
          ],
        ),
      ),
    );
  }
}
