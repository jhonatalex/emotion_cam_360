import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAppBar extends StatelessWidget {
  String title;
  MyAppBar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 30),
      ),
      elevation: 0.0,
      toolbarHeight: 100,
      centerTitle: true,
      backgroundColor: Color.fromARGB(76, 0, 0, 0),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
    );
  }
}
