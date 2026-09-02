import 'package:flutter/material.dart';

import '../../core/utils/extensions.dart';
import '../../data/models/booking_model.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';
import 'network_avatar.dart';
import 'status_badge.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback onTap;

  const BookingCard({super.key, required this.booking, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(booking.serviceTitle, style: AppTextStyles.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                StatusBadge(label: booking.status.label, color: booking.status.color, background: booking.status.surfaceColor),
              ],
            ),
            const SizedBox(height: AppSizes.sm),
            Row(
              children: [
                NetworkAvatar(seed: booking.providerAvatarSeed, radius: 16),
                const SizedBox(width: AppSizes.xs),
                Expanded(
                  child: Text(booking.providerName, style: AppTextStyles.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                Text('\$${booking.price.toStringAsFixed(0)}', style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary)),
              ],
            ),
            const Divider(height: AppSizes.lg),
            Row(
              children: [
                const Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(booking.date.toFullDate, style: AppTextStyles.caption),
                const SizedBox(width: AppSizes.sm),
                const Icon(Icons.access_time_rounded, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(booking.time, style: AppTextStyles.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
