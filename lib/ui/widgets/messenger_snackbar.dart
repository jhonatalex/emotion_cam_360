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
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.violet, width: 2),
            ),
            color: AppColors.vulcan,
          ),
          // margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                //margin: const EdgeInsets.only(left: 20),
                child: Container(
                  height: sclH(context) * 4,
                  width: sclH(context) * 4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 0.5),
                      color: AppColors.violet,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text(
                      "!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sclH(context) * 3.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: sclW(context) * 70,
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
