import 'package:flutter/material.dart';

import 'appcolors.dart';

Container BackgroundGradient(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        tileMode: TileMode.clamp,
        stops: [0.0, 1],
        colors: [
          AppColors.violet,
          AppColors.royalBlue,
        ],
      ),
    ),
  );
}
