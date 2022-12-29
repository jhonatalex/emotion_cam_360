import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:flutter/material.dart';

import 'Background.dart';
import 'my_appbar.dart';

class CarrucelHeader extends StatefulWidget {
  const CarrucelHeader({super.key});

  @override
  State<CarrucelHeader> createState() => _CarrucelHeaderState();
}

class _CarrucelHeaderState extends State<CarrucelHeader> {
  // final CarouselController _carouselController = CarouselController();
  final imgList = [
    'assets/img/sld_0.png',
    'assets/img/sld_1.png',
    'assets/img/sld_2.png',
    'assets/img/sld_3.png',
    'assets/img/sld_4.png'
  ];
  int _current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundBlur(
          imgList: imgList,
          current: _current,
          bgHeight: sclH(context) * 45,
        ),
        Container(
          margin: EdgeInsets.only(top: sclH(context) * 10),
          child: CarouselSlider(
            options: CarouselOptions(
              height: sclH(context) * 35,
              viewportFraction: 0.45, //width
              aspectRatio: 16 / 9,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
              onPageChanged: ((index, reason) {
                setState(() {
                  _current = index;
                });
              }),
            ),
            items: imgList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(i), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(30)),
                  );
                },
              );
            }).toList(),
          ),
        ),
        MyAppBar('EMOTION CAM 365'),
      ],
    );
  }
}
