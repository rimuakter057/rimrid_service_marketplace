import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controllers/auth_controller.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'alex.morgan@example.com');
  final passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    isLoading.value = true;
    await Get.find<AuthController>().login(
      email: emailController.text.trim(),
      password: passwordController.text,
    );
    isLoading.value = false;
    Get.offAllNamed(AppRoutes.main);
  }

  void goToSignup() => Get.toNamed(AppRoutes.signup);
}
