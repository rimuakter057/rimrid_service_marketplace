import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/bookings_controller.dart';
import '../controllers/favorites_controller.dart';
import '../controllers/notifications_controller.dart';

/// Registers controllers that must stay alive for the lifetime of the app,
/// independent of which route is currently pushed.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(FavoritesController(), permanent: true);
    Get.put(BookingsController(), permanent: true);
    Get.put(NotificationsController(), permanent: true);
  }
}
