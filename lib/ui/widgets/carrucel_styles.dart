import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
          const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.star),
                text: 'Populares',
              ),
              Tab(
                icon: Icon(Icons.recent_actors),
                text: 'Nuevos',
              ),
              Tab(
                icon: Icon(Icons.six_mp_outlined),
                text: 'Minimalista',
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 170,
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
        height: 150,
        aspectRatio: 16 / 9,
        viewportFraction: 0.3,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        //autoPlay: true,
        // autoPlayInterval: Duration(seconds: 5),
        // autoPlayAnimationDuration: Duration(milliseconds: 800),
        //autoPlayCurve: Curves.fastOutSlowIn,
        // enlargeCenterPage: true,
        // enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
        /*  onPageChanged: ((index, reason) {
          setState(() {
            _current = index;
          });
        }), */
      ),
      items: imgList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: 250,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(i), fit: BoxFit.cover),
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(25)),
            );
          },
        );
      }).toList(),
    );
  }
}
