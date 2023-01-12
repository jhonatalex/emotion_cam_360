import 'package:emotion_cam_360/repositories/abstractas/appcolors.dart';
import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:flutter/material.dart';

bool isConected = true;

var icon = Icons.bluetooth_disabled;
var icolor = Colors.red;

// ignore: must_be_immutable
class MyAppBar extends StatefulWidget {
  String title;
  MyAppBar(this.title, {super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return AppBar(
      key: _scaffoldKey,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(
            Icons.menu,
            size: sclH(context) * 3,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(
        widget.title,
        style: TextStyle(fontSize: sclW(context) * 5),
      ),
      elevation: 0.0,
      toolbarHeight: sclH(context) * 7,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CircleAvatar(
            radius: sclH(context) * 2.5,
            backgroundColor: AppColors.vulcan,
            /* backgroundImage: AssetImage(
              "assets/img/background.png",
              
            ), */
            child: IconButton(
                onPressed: () {
                  setState(() {
                    if (isConected) {
                      icon = Icons.bluetooth_connected;
                      isConected = false;
                      icolor = Colors.blue;
                    } else {
                      icon = Icons.bluetooth_disabled;
                      isConected = true;
                      icolor = Colors.red;
                    }
                  });
                },
                icon: Icon(
                  icon,
                  size: sclH(context) * 2.5,
                  color: icolor,
                )),
          ),
        )
      ],
    );
  }
}
