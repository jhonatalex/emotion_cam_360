import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  String title;
  MyAppBar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 30),
      ),
      elevation: 0.0,
      toolbarHeight: 100,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
    );
  }
}
