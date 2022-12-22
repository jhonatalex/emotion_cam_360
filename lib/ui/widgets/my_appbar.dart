import 'package:emotion_cam_360/repositories/abstractas/responsive.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAppBar extends StatelessWidget {
  String title;
  MyAppBar(this.title, {super.key});

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
        title,
        style: TextStyle(fontSize: sclH(context) * 4),
      ),
      elevation: 0.0,
      toolbarHeight: sclH(context) * 7,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
          iconSize: sclH(context) * 3,
        )
      ],
    );
  }
}
