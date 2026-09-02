import 'package:get/get.dart';

import '../../../core/controllers/notifications_controller.dart';

/// The underlying NotificationsController is already registered permanently
/// in InitialBinding — nothing feature-specific to bind here, but the route
/// keeps a binding for consistency and future feature-local state.
class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<NotificationsController>()) {
      Get.put(NotificationsController(), permanent: true);
    }
  }
}
