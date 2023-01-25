import 'package:flutter/material.dart';

import 'appcolors.dart';

MessengerSnackBar(context, text) {
  final snackbar = SnackBar(
    backgroundColor: AppColors.violet,
    content: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
