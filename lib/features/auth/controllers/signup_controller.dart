import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controllers/auth_controller.dart';
import '../../../routes/app_routes.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool agreedToTerms = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleTerms(bool? value) => agreedToTerms.value = value ?? false;

  Future<void> signup() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    if (!agreedToTerms.value) {
      Get.snackbar('Almost there', 'Please agree to the Terms & Privacy Policy to continue.');
      return;
    }
    isLoading.value = true;
    await Get.find<AuthController>().signup(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.main);
  }

  void goToLogin() => Get.back();
}
