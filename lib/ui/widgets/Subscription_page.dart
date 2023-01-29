import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:emotion_cam_360/ui/widgets/responsive.dart';
import 'package:flutter/material.dart';

final ScrollController _controller = ScrollController();

class SubscriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double xOffset = 200;
    double yOffset = 500;
    final left1 = sclW(context) * 15;
    final top1 = sclH(context) * 5;
    final left2 = sclW(context) * 10;
    final top2 = sclH(context) * 65;
    final left3 = sclW(context) * 55;
    final top3 = sclH(context) * 65;

    return Scaffold(
      backgroundColor: AppColors.vulcan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "SUBSCRIPCIONES",
            style: TextStyle(fontSize: sclW(context) * 5),
          ),
          centerTitle: true),
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          controller: _controller,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              transform: Matrix4.translationValues(0, 0, 0)..scale(01.0),
              child: SubscriptionCard(context),
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              //transform: Matrix4.translationValues(left2, top2, 0)..scale(0.5),
              child: SubscriptionCard(context),
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              // transform: Matrix4.translationValues(left3, top3, 0)..scale(0.5),
              child: SubscriptionCard(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget SubscriptionCard(context) {
    return Container(
      width: sclW(context) * 70,
      height: sclW(context) * 100,
      margin: EdgeInsets.symmetric(
          vertical: sclW(context) * 5, horizontal: sclW(context) * 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "Standard",
              style: TextStyle(
                  color: AppColors.royalBlue, fontSize: sclW(context) * 6),
            ),
          ),
          Container(
            width: sclW(context) * 64,
            height: sclW(context) * 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              ),
              color: AppColors.royalBlue,
            ),
            margin: EdgeInsets.only(
              left: sclW(context) * 5,
            ),
            padding: EdgeInsets.all(
              sclW(context) * 2,
            ),
            child: Column(
              children: [
                ListTile(
                  trailing: const Icon(Icons.check_circle_outline),
                  title: Text(
                    "Subscripción anual",
                    style: TextStyle(fontSize: sclW(context) * 4),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(
                    "Subscripción anual",
                    style: TextStyle(fontSize: sclW(context) * 4),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(
                    "Subscripción anual",
                    style: TextStyle(fontSize: sclW(context) * 4),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(
                    "Subscripción anual",
                    style: TextStyle(fontSize: sclW(context) * 4),
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.home,
                    size: 40,
                  ),
                  foregroundColor: AppColors.violet,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: sclW(context) * 3,
            ),
            child: ElevatedButton(
              onPressed: () {},
              child: Text("99,99"),
            ),
          ),
        ],
      ),
    );
  }
}
