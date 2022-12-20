import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(0, 20, 18, 32),
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Image.asset(
            "assets/img/logo-emotion.png",
            height: 100,
          ),
          Text(
            'EMOTION \n CAM 360',
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
          SizedBox(
            height: 50,
          ),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            tileColor: Colors.black38,
            leading: Icon(
              Icons.home,
            ),
            title: Text('Home'),
          ),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            tileColor: Colors.black38,
            leading: Icon(
              Icons.home,
            ),
            title: Text('Home'),
          ),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            tileColor: Colors.black38,
            leading: Icon(
              Icons.home,
            ),
            title: Text('Home'),
          ),
        ],
      ),
    );
  }
}
