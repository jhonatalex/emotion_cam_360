import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Show a red snackbar with the error information.
class ErrorSnackbar extends GetSnackBar {
  const ErrorSnackbar(final String message, {Key? key})
      : super(key: key, message: message);

  @override
  Color get backgroundColor => const Color.fromARGB(255, 255, 255, 255);

  @override
  Widget? get icon =>
      const Icon(Icons.error_outline, color: Color.fromARGB(255, 0, 0, 0));

  @override
  Widget? get mainButton {
    return IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.close_outlined),
    );
  }

  @override
  // ignore: todo
  // TODO: implement duration
  Duration? get duration => const Duration(seconds: 5);

  @override
  Widget? get messageText {
    return SelectableText(
      message!,
      style: const TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }

  @override
  SnackPosition get snackPosition => SnackPosition.TOP;
}
