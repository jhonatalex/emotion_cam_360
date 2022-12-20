import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currrent = 2;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currrent,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: Colors.transparent,
      //  Color.fromARGB(250, 20, 18, 32),

      selectedFontSize: 25,
      selectedItemColor: Colors.red,
      selectedIconTheme: IconThemeData(size: 60),
      unselectedFontSize: 20,
      unselectedItemColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.image_outlined),
          label: 'Fondo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.filter_b_and_w),
          label: 'Filtro',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_camera_back_outlined),
          label: 'Video',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_enhance_sharp),
          label: 'Efecto',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Ajustes',
        ),
      ],
      onTap: (value) {
        _currrent = value;
        setState(() {});
      },
    );
  }
}
