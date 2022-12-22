import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundBlur extends StatelessWidget {
  const BackgroundBlur({
    Key? key,
    required this.imgList,
    required int current,
    required this.bgHeight,
  })  : _current = current,
        super(key: key);

  final List<String> imgList;
  final int _current;
  final bgHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: bgHeight,
          child: ClipRRect(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Image.asset(
                imgList[_current],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  const Color(0xff141220).withOpacity(1),
                  const Color(0xff141220).withOpacity(1),
                  const Color(0xff141220).withOpacity(1),
                  const Color(0xff141220).withOpacity(0.9),
                  const Color(0xff141220).withOpacity(0.8),
                  const Color(0xff141220).withOpacity(0.7),
                  const Color(0xff141220).withOpacity(0.6),
                  const Color(0xff141220).withOpacity(0.5),
                  const Color(0xff141220).withOpacity(0.4),
                  const Color(0xff141220).withOpacity(0.3),
                  const Color(0xff141220).withOpacity(0.2),
                  const Color(0xff141220).withOpacity(0),
                  const Color(0xff141220).withOpacity(0),
                  const Color(0xff141220).withOpacity(0),
                ])),
          ),
        ),
      ],
    );
  }
}
