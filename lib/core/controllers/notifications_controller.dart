import 'package:get/get.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/notification_model.dart';

class NotificationsController extends GetxController {
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    notifications.assignAll(MockData.notifications);
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) notifications[index] = notifications[index].copyWith(isRead: true);
  }

  void markAllAsRead() {
    notifications.assignAll(notifications.map((n) => n.copyWith(isRead: true)));
  }
}
