import 'package:get/get.dart';

class SettingsController extends GetxController {
  final RxBool pushNotifications = true.obs;
  final RxBool emailNotifications = true.obs;
  final RxBool smsNotifications = false.obs;
  final RxBool darkMode = false.obs;
  final RxString language = 'English'.obs;
  final RxString currency = 'USD (\$)'.obs;

  void togglePush(bool v) => pushNotifications.value = v;
  void toggleEmail(bool v) => emailNotifications.value = v;
  void toggleSms(bool v) => smsNotifications.value = v;

  void toggleDarkMode(bool v) {
    darkMode.value = v;
    Get.snackbar('Coming soon', 'Dark theme will be available in a future update.');
  }
}
