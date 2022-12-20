// ignore: file_names
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stackBackground = Stack(children: [
      Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF2196f3),
          )),
      ClipPath(
          clipper: WaveClipper(), //Puedes usar WaveClipper oWaveClipper1
          child: Container(
              height: 520,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 231, 231, 233))))
    ]);
    return stackBackground;
  }
}

// ignore: must_be_immutable
class BackgroundImagen extends StatelessWidget {
  String pathImage = "assets/img/fondo-home.jpg";
  BackgroundImagen(this.pathImage, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var stackBackgroundImagen = Stack(children: [
      Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF2196f3),
          )),
      ClipPath(
          clipper: WaveClipper(), //Puedes usar WaveClipper oWaveClipper1
          child: Container(
              height: 300,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 231, 231, 233),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(pathImage),
                    /*colorFilter: ColorFilter.mode(
                          Color.fromRGBO(255, 255, 255, 0.70),
                          BlendMode.srcATop)*/
                  ))))
    ]);
    return stackBackgroundImagen;
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 100);
    var firstStart = Offset(size.width / 4, size.height - 20);
    var firstEnd = Offset(size.width / 2, size.height - 60);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart = Offset(size.width / 2 + size.width / 4, size.height - 80);
    var secondEnd = Offset(size.width, size.height - 20);

    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 100);
    var firstStart = Offset(size.width / 6, size.height - 40);
    var firstEnd = Offset(size.width / 2 - size.width / 6, size.height - 60);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart = Offset(size.width / 2, size.height - 80);
    var secondEnd = Offset(size.width / 2 + size.width / 6, size.height - 40);

    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    var thirdStart = Offset(size.width - (size.width / 6), size.height - 0);
    var thirdEnd = Offset(size.width, size.height - 20);

    path.quadraticBezierTo(
        thirdStart.dx, thirdStart.dy, thirdEnd.dx, thirdEnd.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
