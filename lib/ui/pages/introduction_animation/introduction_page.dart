// ignore_for_file: library_private_types_in_public_api

import 'package:emotion_cam_360/ui/pages/introduction_animation/components/design_efect_view.dart';
import 'package:emotion_cam_360/ui/pages/introduction_animation/components/center_next_button.dart';
import 'package:emotion_cam_360/ui/pages/introduction_animation/components/record_share_view.dart';
import 'package:emotion_cam_360/ui/pages/introduction_animation/components/events_view.dart';
import 'package:emotion_cam_360/ui/pages/introduction_animation/components/welcome_view.dart';
import 'package:emotion_cam_360/ui/pages/introduction_animation/components/top_back_skip_view.dart';
import 'package:emotion_cam_360/ui/pages/introduction_animation/components/start_view.dart';
import 'package:emotion_cam_360/ui/routes/route_names.dart';
import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key, required this.isLoginFunction})
      : super(key: key);
  final VoidCallback isLoginFunction;

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  bool showWelcome = true; // Valor predeterminado para mostrar la pantalla de bienvenida



  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8));
    _animationController?.animateTo(0.0);


    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
     checkShowWelcomeScreen();
    super.dispose();
  }


 Future<void> checkShowWelcomeScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final showWelcomePref = prefs.getBool('showWelcomeScreen');

    if (showWelcomePref != null && !showWelcomePref) {

      Get.offAllNamed(RouteNames.signIn);
     
    } else {
   
      setState(() {
        showWelcome = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vulcan,
      body: ClipRect(
        child: Stack(
          children: [
            SplashView(
              animationController: _animationController!,
            ),
            RelaxView(
              animationController: _animationController!,
            ),
            CareView(
              animationController: _animationController!,
            ),
            MoodDiaryVew(
              animationController: _animationController!,
            ),
            WelcomeView(
              animationController: _animationController!,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController!,
            ),
            CenterNextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: const Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 &&
        _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 &&
        _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 &&
        _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _startClick();
    }
  }

  void _startClick() async {
    //Navigator.pop(context);
    /* ACTUALIZAR LA VARIABLE AQUÍ */
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showWelcomeScreen', false);
    Get.offNamed(RouteNames.signIn);
  }

  Future<void> markWelcomeScreenAsSeen() async {
    //final prefs = await SharedPreferences.getInstance();
    //await prefs.setBool('showWelcomeScreen', false);
  }


}
