import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/network_avatar.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../data/models/booking_model.dart';
import '../controllers/booking_details_controller.dart';

class BookingDetailsView extends GetView<BookingDetailsController> {
  const BookingDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Booking Details'),
      body: Obx(() {
        final booking = controller.booking;
        return ListView(
          padding: const EdgeInsets.all(AppSizes.lg),
          children: [
            Container(
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
                      Expanded(child: Text(booking.serviceTitle, style: AppTextStyles.h4)),
                      StatusBadge(label: booking.status.label, color: booking.status.color, background: booking.status.surfaceColor),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(booking.categoryName, style: AppTextStyles.caption),
                  const Divider(height: AppSizes.xl),
                  Row(
                    children: [
                      NetworkAvatar(seed: booking.providerAvatarSeed, radius: 24),
                      const SizedBox(width: AppSizes.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(booking.providerName, style: AppTextStyles.labelLarge),
                            Text('Service Provider', style: AppTextStyles.caption),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: controller.messageProvider,
                        icon: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.lg),
            _DetailCard(
              children: [
                _DetailRow(icon: Icons.calendar_today_rounded, label: 'Date', value: booking.date.toFullDate),
                _DetailRow(icon: Icons.access_time_rounded, label: 'Time', value: booking.time),
                _DetailRow(icon: Icons.location_on_outlined, label: 'Address', value: booking.address),
                _DetailRow(icon: Icons.payment_rounded, label: 'Payment', value: booking.paymentMethod),
                if (booking.note != null) _DetailRow(icon: Icons.edit_note_rounded, label: 'Note', value: booking.note!),
              ],
            ),
            const SizedBox(height: AppSizes.lg),
            _DetailCard(
              children: [
                _DetailRow(icon: Icons.receipt_long_rounded, label: 'Service Fee', value: '\$${booking.price.toStringAsFixed(2)}'),
                if (booking.tipAmount != null)
                  _DetailRow(icon: Icons.volunteer_activism_rounded, label: 'Tip', value: '\$${booking.tipAmount!.toStringAsFixed(2)}'),
                Padding(
                  padding: const EdgeInsets.only(top: AppSizes.xs),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTextStyles.labelLarge),
                      Text(
                        '\$${(booking.price + (booking.tipAmount ?? 0)).toStringAsFixed(2)}',
                        style: AppTextStyles.h4.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.xl),
            if (booking.status == BookingStatus.upcoming || booking.status == BookingStatus.pending)
              CustomButton(label: 'Cancel Booking', variant: CustomButtonVariant.danger, onPressed: controller.cancelBooking),
            if (booking.status == BookingStatus.completed)
              CustomButton(label: 'Leave a Review', icon: Icons.star_border_rounded, onPressed: controller.leaveReview),
          ],
        );
      }),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final List<Widget> children;
  const _DetailCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(children: children),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: AppSizes.xs),
          SizedBox(width: 74, child: Text(label, style: AppTextStyles.caption)),
          Expanded(child: Text(value, style: AppTextStyles.bodyMedium)),
        ],
      ),
    );
  }
}
