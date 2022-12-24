import 'package:emotion_cam_360/ui/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repositories/abstractas/appcolors.dart';
import '../../../repositories/abstractas/responsive.dart';
import '../../routes/route_names.dart';
import '../../widgets/camera.dart';
import 'camera_controller.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  int _selectedIndex = 2;
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Fondo',
      style: TextStyle(fontSize: 50),
    ),
    Text(
      'Filtro',
      style: TextStyle(fontSize: 50),
    ),
    CameraApp2(),
    Text(
      'Efecto',
      style: TextStyle(fontSize: 50),
    ),
    SettingsVideo(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: sclH(context) * 7,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              iconSize: sclH(context) * 3,
              onPressed: (() => Get.offNamed(RouteNames.menu)),
            ),
          ),
          backgroundColor: AppColors.vulcan,
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: Container(
            height: 161,
            color: AppColors.vulcan,
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    var _height = constraints.maxHeight;
                    var _widthItem = constraints.maxWidth / 5;
                    var _paddingItem = (_widthItem - 85) / 2;
                    print("alto: $_height  ancho: $_widthItem  ");

                    return Padding(
                      padding: EdgeInsets.only(
                        left: _widthItem * _selectedIndex + _paddingItem,
                      ), //
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 45),
                            width: 85,
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                          Container(
                            width: 85,
                            margin: EdgeInsets.only(bottom: 100),
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.rectangle),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 150),
                            width: 85,
                            height: 5,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  height: 3,
                  color: Colors.white,
                ),
                BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  //  Color.fromARGB(250, 20, 18, 32),

                  selectedFontSize: sclH(context) * 3,
                  selectedItemColor: AppColors.royalBlue,
                  selectedIconTheme: IconThemeData(size: sclH(context) * 6),
                  unselectedFontSize: sclH(context) * 2,
                  unselectedItemColor: Colors.white,
                  unselectedIconTheme: IconThemeData(size: sclH(context) * 3),
                  items: const [
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
                    _selectedIndex = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
