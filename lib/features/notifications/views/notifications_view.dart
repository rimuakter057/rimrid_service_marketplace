import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/controllers/notifications_controller.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/models/notification_model.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationsController>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Notifications',
        actions: [
          TextButton(
            onPressed: controller.markAllAsRead,
            child: Text('Mark all read', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
      body: Obx(() {
        final items = controller.notifications;
        if (items.isEmpty) {
          return const EmptyState(icon: Icons.notifications_none_rounded, title: 'You\'re all caught up', message: 'New notifications will appear here.');
        }
        return ListView.separated(
          padding: const EdgeInsets.all(AppSizes.lg),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSizes.sm),
          itemBuilder: (context, index) {
            final n = items[index];
            return GestureDetector(
              onTap: () => controller.markAsRead(n.id),
              child: Container(
                padding: const EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  color: n.isRead ? AppColors.surface : AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                  boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 3))],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(color: n.type.color.withValues(alpha: 0.12), shape: BoxShape.circle),
                      child: Icon(n.type.icon, color: n.type.color, size: 18),
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(n.title, style: AppTextStyles.labelLarge),
                          const SizedBox(height: 2),
                          Text(n.message, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                          const SizedBox(height: 6),
                          Text(n.time.toDayMonthTime, style: AppTextStyles.caption),
                        ],
                      ),
                    ),
                    if (!n.isRead)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
