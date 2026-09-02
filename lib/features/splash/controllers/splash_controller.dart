import 'package:get/get.dart';

import '../../../core/controllers/auth_controller.dart';
import '../../../core/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 1800));
    final auth = Get.find<AuthController>();
    if (!StorageService.hasSeenOnboarding) {
      Get.offAllNamed(AppRoutes.onboarding);
    } else if (auth.isLoggedIn) {
      Get.offAllNamed(AppRoutes.main);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
