import 'package:carousel_slider/carousel_slider.dart';
import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:flutter/material.dart';

import '../../repositories/abstractas/responsive.dart';

class CarrucelStyles extends StatefulWidget {
  const CarrucelStyles({super.key});

  @override
  State<CarrucelStyles> createState() => _CarrucelStylesState();
}

class _CarrucelStylesState extends State<CarrucelStyles> {
  // final CarouselController _carouselController = CarouselController();
  final imgList = [
    'assets/img/sld_0.png',
    'assets/img/sld_1.png',
    'assets/img/sld_2.png',
    'assets/img/sld_3.png',
    'assets/img/sld_4.png'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            padding: EdgeInsets.only(bottom: sclH(context) * 2),
            indicatorColor: AppColors.violet,
            // labelColor: AppColors.violet,
            labelStyle: TextStyle(fontSize: sclH(context) * 2),
            tabs: [
              Tab(
                height: sclH(context) * 8,
                icon: Icon(
                  Icons.star,
                  size: sclH(context) * 3,
                ),
                text: 'Populares',
              ),
              Tab(
                height: sclH(context) * 8,
                icon: Icon(
                  Icons.recent_actors,
                  size: sclH(context) * 3,
                ),
                text: 'Nuevos',
              ),
              Tab(
                height: sclH(context) * 8,
                icon: Icon(
                  Icons.six_mp_outlined,
                  size: sclH(context) * 3,
                ),
                text: 'Minimalista',
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: sclH(context) * 27,
            child: TabBarView(
              children: [
                PopularesSlider(imgList: imgList),
                PopularesSlider(imgList: imgList),
                PopularesSlider(imgList: imgList),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PopularesSlider extends StatelessWidget {
  const PopularesSlider({
    Key? key,
    required this.imgList,
  }) : super(key: key);

  final List<String> imgList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: sclH(context) * 25,
        aspectRatio: 16 / 9,
        viewportFraction: 0.3,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        scrollDirection: Axis.horizontal,
      ),
      items: imgList.map((i) {
        print(sclH(context));
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: sclH(context) * 20,
              margin: EdgeInsets.symmetric(horizontal: sclH(context) / 2),
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(i), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(25)),
            );
          },
        );
      }).toList(),
    );
  }
}
