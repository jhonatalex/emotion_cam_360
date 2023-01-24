import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class Sharebuttons extends StatelessWidget {
  String video;
  Sharebuttons(
    this.video, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Share.share(
            'Maravillosa aventura! \nQuiero compartirla contigo... \n' +
                'Visualiza mi video en: \n$video',
            subject: 'Mira lo que he hecho!');
      },
      icon: Icon(Icons.share),
      label: Text("Compartir"),
    );
  }
}
