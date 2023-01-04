import 'package:flutter/material.dart';

import '../../repositories/abstractas/appcolors.dart';

Container BackgroundGradient(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
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
