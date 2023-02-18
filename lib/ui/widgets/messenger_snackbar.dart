import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:flutter/material.dart';

import 'appcolors.dart';

MessengerSnackBar(context, text) {
  final snackbar = SnackBar(
    backgroundColor: Colors.transparent,
    padding: EdgeInsets.zero,
    elevation: 0,
    content: Stack(
      children: [
        Container(
          width: sclW(context) * 100,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 20),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          color: AppColors.violet,
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Container(
            height: sclH(context) * 3,
            width: sclH(context) * 3,
            child: Center(
              child: Text(
                "!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: sclH(context) * 2.5,
                ),
              ),
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 0.5),
                color: AppColors.violet,
                borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ],
    ),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
