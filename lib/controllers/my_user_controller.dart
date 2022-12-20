import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../entities/user.dart';
import '../repositories/abstractas/my_user_repository.dart';

class MyUserController extends GetxController {
  final _userRepository = Get.find<MyUserRepository>();

  final nameController = TextEditingController();
  final rutController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();

  Rx<File?> pickedImage = Rx(null);
  Rx<bool> isLoading = Rx(false);
  Rx<bool> isSaving = Rx(false);
  Rx<MyUser?> user = Rx(null);

  @override
  void onInit() {
    getMyUser();
    super.onInit();
  }

  void setImage(File? imageFile) async {
    pickedImage.value = imageFile;
  }

  Future<void> getMyUser() async {
    isLoading.value = true;
    user.value = await _userRepository.getMyUser();
    nameController.text = user.value?.name ?? '';
    rutController.text = user.value?.rut ?? '';
    phoneController.text = user.value?.telefono ?? '';
    cityController.text = user.value?.ciudad.toString() ?? '';
    user.value?.balance ?? 0;

    isLoading.value = false;
  }

  Future<void> saveMyUser() async {
    isSaving.value = true;
    const uid = "0001";
    final name = nameController.text;
    final telefono = phoneController.text;
    final ciudad = cityController.text;
    final rut = rutController.text;
    const balance = 0;
    final newUser = MyUser(uid, name, telefono, ciudad, rut, balance,
        image: user.value?.image);
    user.value = newUser;

    // For testing add delay
    //await Future.delayed(const Duration(seconds: 3));
    await _userRepository.saveMyUser(newUser, pickedImage.value);
    isSaving.value = false;
  }
}
