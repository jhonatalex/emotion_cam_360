import 'package:emotion_cam_360/ui/widgets/responsive.dart';
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
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return AppBar(
      key: scaffoldKey,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, size: sclH(context) * 3, shadows: const [
            Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 2)
          ]),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text(
        widget.title,
        style: TextStyle(fontSize: sclW(context) * 5, shadows: const [
          Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 2)
        ]),
      ),
      elevation: 0.0,
      toolbarHeight: sclH(context) * 7,
      centerTitle: true,
      backgroundColor: Colors.transparent,
    
    );
  }
}
