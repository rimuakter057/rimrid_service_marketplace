import 'package:get/get.dart';

import '../../../core/controllers/auth_controller.dart';
import '../../../routes/app_routes.dart';

class ProfileController extends GetxController {
  AuthController get auth => Get.find<AuthController>();

  void goToEditProfile() => Get.toNamed(AppRoutes.editProfile);
  void goToSettings() => Get.toNamed(AppRoutes.settings);
  void goToNotifications() => Get.toNamed(AppRoutes.notifications);
  void goToChats() => Get.toNamed(AppRoutes.chatList);
  void goToFavorites() => Get.toNamed(AppRoutes.favorites);

  void goToProviderDashboard() {
    auth.isProviderMode.value = true;
    Get.toNamed(AppRoutes.providerDashboard);
  }

  void logout() {
    Get.defaultDialog(
      title: 'Log out',
      middleText: 'Are you sure you want to log out?',
      textConfirm: 'Log out',
      textCancel: 'Cancel',
      confirmTextColor: Get.theme.colorScheme.onPrimary,
      onConfirm: () {
        auth.logout();
        Get.offAllNamed(AppRoutes.login);
      },
    );
  }
}
