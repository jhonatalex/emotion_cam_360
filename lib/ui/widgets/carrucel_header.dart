import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
        SizedBox(
          width: double.infinity,
          height: 350,
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
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  const Color(0xff141220).withOpacity(1),
                  const Color(0xff141220).withOpacity(1),
                  const Color(0xff141220).withOpacity(0),
                  const Color(0xff141220).withOpacity(0),
                  const Color(0xff141220).withOpacity(0.0),
                  const Color(0xff141220).withOpacity(0),
                  const Color(0xff141220).withOpacity(0.0),
                ])),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 100),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 300,
              aspectRatio: 16 / 9,
              viewportFraction: 0.5,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                    width: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(i), fit: BoxFit.cover),
                        color: Color.fromARGB(183, 0, 0, 0),
                        borderRadius: BorderRadius.circular(25)),
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
