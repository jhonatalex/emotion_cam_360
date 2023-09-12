import 'package:flutter/material.dart';

class MoodDiaryVew extends StatelessWidget {
  final AnimationController animationController;

  const MoodDiaryVew({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstHalfAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final secondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final moodFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final moodSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final imageFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(4, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final imageSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-4, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: firstHalfAnimation,
      child: SlideTransition(
        position: secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Graba y Comparte",
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              SlideTransition(
                position: moodFirstHalfAnimation,
                child: SlideTransition(
                  position: moodSecondHalfAnimation,
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 40, right: 40, top: 16, bottom: 16),
                    child: Text(
                      "Inicia la grabación y la app procesará automáticamente tu video, Una vez que la grabación esté lista. se generará un QR que podrás compartir.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: imageFirstHalfAnimation,
                child: SlideTransition(
                  position: imageSecondHalfAnimation,
                  child: Container(
                    constraints:
                        const BoxConstraints(maxWidth: 350, maxHeight: 250),
                    child: Image.asset(
                      'assets/introduction_animation/mood_dairy_image.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
