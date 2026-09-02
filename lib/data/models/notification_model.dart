import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

enum NotificationType { booking, promo, system, message }

extension NotificationTypeMeta on NotificationType {
  IconData get icon {
    switch (this) {
      case NotificationType.booking:
        return Icons.event_available_rounded;
      case NotificationType.promo:
        return Icons.local_offer_rounded;
      case NotificationType.system:
        return Icons.info_rounded;
      case NotificationType.message:
        return Icons.chat_bubble_rounded;
    }
  }

  Color get color {
    switch (this) {
      case NotificationType.booking:
        return AppColors.info;
      case NotificationType.promo:
        return AppColors.primary;
      case NotificationType.system:
        return AppColors.textSecondary;
      case NotificationType.message:
        return AppColors.success;
    }
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  final NotificationType type;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
  });

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      message: message,
      time: time,
      type: type,
      isRead: isRead ?? this.isRead,
    );
  }
}
