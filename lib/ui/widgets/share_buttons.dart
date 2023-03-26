import 'package:emotion_cam_360/ui/widgets/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class Sharebuttons extends StatelessWidget {
  String video;
  String title;
  Sharebuttons(
    this.video,
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Share.share(
            'Maravillosa aventura! \nQuiero compartirla contigo... \n Visualiza mi video en: \n$video',
            subject: 'Mira lo que he hecho!');
      },
      icon: const Icon(Icons.share),
      label: Text(title),
      style: ButtonStyle(
        elevation: MaterialStatePropertyAll<double>(
          title == "" ? 0 : 1,
        ),
        backgroundColor: MaterialStatePropertyAll<Color>(
          title == "" ? Colors.transparent : AppColors.royalBlue,
        ),
      ),
    );
  }
}
