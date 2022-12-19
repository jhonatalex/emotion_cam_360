// ignore_for_file: camel_case_types, constant_identifier_names

import 'package:flutter/material.dart';

class shadowStyle extends StatelessWidget {
  const shadowStyle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

const doSpace20 = SizedBox(
  height: 20,
  width: 20,
);

const doSpace10 = SizedBox(
  height: 10,
  width: 10,
);

// ignore: must_be_immutable
class GradientBack extends StatelessWidget {
  var color1 = const Color(0xff426bd3);
  var color2 = const Color(0xff5d4bd1);
  int radius = 10;
  GradientBack(this.color1, this.color2, this.radius, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              colors: [
                Color(0xff426bd3),
                Color(0xff5d4bd1),
              ],
              begin: FractionalOffset(0.3, 0.0),
              end: FractionalOffset(1.0, 0.6),
              stops: [0.0, 0.6],
              tileMode: TileMode.clamp,
            )));
  }
}

//LISTADO DE SOMBRAS
const ShadowBlack = BoxShadow(
  color: Colors.black,
  blurStyle: BlurStyle.inner,
  offset: Offset(-3.0, 2.0),
  blurRadius: 5,
);
const ShadowBlueDown = BoxShadow(
  color: Colors.blue,
  blurStyle: BlurStyle.inner,
  offset: Offset(0.0, 5.0),
  blurRadius: 5,
);
//LISTADO DE GRADIENTES
const GradientPurple = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xff426bd3),
    Color(0xff5d4bd1),
  ],
);
const GradientRed = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromARGB(255, 212, 38, 38),
    Color.fromARGB(255, 214, 139, 26),
  ],
);
const GradientPink = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromARGB(255, 107, 26, 214),
    Color.fromARGB(255, 212, 38, 189),
  ],
);
const GradientGreen = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color.fromARGB(255, 15, 163, 47),
    Color.fromARGB(255, 98, 240, 16),
  ],
);
const GradientBlue = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Color.fromARGB(255, 28, 192, 238),
    Color.fromARGB(255, 15, 67, 163),
  ],
);
