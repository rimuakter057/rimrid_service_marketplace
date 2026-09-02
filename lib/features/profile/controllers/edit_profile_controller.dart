import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controllers/auth_controller.dart';
import '../../../data/mock/mock_data.dart';

class EditProfileController extends GetxController {
  AuthController get auth => Get.find<AuthController>();

  late final nameController = TextEditingController(text: auth.user.value?.name ?? MockData.currentUser.name);
  late final emailController = TextEditingController(text: auth.user.value?.email ?? MockData.currentUser.email);
  late final phoneController = TextEditingController(text: auth.user.value?.phone ?? MockData.currentUser.phone);
  late final addressController = TextEditingController(text: auth.user.value?.address ?? MockData.currentUser.address);
  final RxBool isSaving = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future<void> save() async {
    isSaving.value = true;
    await Future.delayed(const Duration(milliseconds: 700));
    final current = auth.user.value ?? MockData.currentUser;
    auth.updateProfile(current.copyWith(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
    ));
    isSaving.value = false;
    Get.back();
    Get.snackbar('Profile updated', 'Your changes have been saved.');
  }
}
