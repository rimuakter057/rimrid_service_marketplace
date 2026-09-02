import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/network_avatar.dart';
import '../../../data/models/booking_model.dart';
import '../controllers/booking_requests_controller.dart';

class BookingRequestsView extends GetView<BookingRequestsController> {
  const BookingRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          final pending = controller.pending;
          final upcoming = controller.upcoming;
          if (pending.isEmpty && upcoming.isEmpty) {
            return const EmptyState(
              icon: Icons.inbox_outlined,
              title: 'No booking requests',
              message: 'New booking requests from customers will show up here.',
            );
          }
          return ListView(
            padding: const EdgeInsets.all(AppSizes.lg),
            children: [
              Text('Booking Requests', style: AppTextStyles.h2),
              const SizedBox(height: AppSizes.lg),
              if (pending.isNotEmpty) ...[
                Text('Awaiting your response', style: AppTextStyles.h4),
                const SizedBox(height: AppSizes.sm),
                ...pending.map((b) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSizes.sm),
                      child: _RequestCard(booking: b, controller: controller),
                    )),
                const SizedBox(height: AppSizes.lg),
              ],
              if (upcoming.isNotEmpty) ...[
                Text('Confirmed upcoming', style: AppTextStyles.h4),
                const SizedBox(height: AppSizes.sm),
                ...upcoming.map((b) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSizes.sm),
                      child: _ConfirmedCard(booking: b),
                    )),
              ],
            ],
          );
        }),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final BookingModel booking;
  final BookingRequestsController controller;

  const _RequestCard({required this.booking, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              NetworkAvatar(seed: booking.providerAvatarSeed, radius: 20),
              const SizedBox(width: AppSizes.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking.serviceTitle, style: AppTextStyles.labelLarge),
                    Text('${booking.date.toFullDate} · ${booking.time}', style: AppTextStyles.caption),
                  ],
                ),
              ),
              Text('\$${booking.price.toStringAsFixed(0)}', style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: AppSizes.xs),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Expanded(child: Text(booking.address, style: AppTextStyles.caption, maxLines: 1, overflow: TextOverflow.ellipsis)),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          Row(
            children: [
              Expanded(
                child: CustomButton(label: 'Decline', variant: CustomButtonVariant.outlined, height: 42, onPressed: () => controller.decline(booking)),
              ),
              const SizedBox(width: AppSizes.sm),
              Expanded(
                child: CustomButton(label: 'Accept', height: 42, onPressed: () => controller.accept(booking)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConfirmedCard extends StatelessWidget {
  final BookingModel booking;
  const _ConfirmedCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          NetworkAvatar(seed: booking.providerAvatarSeed, radius: 20),
          const SizedBox(width: AppSizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(booking.serviceTitle, style: AppTextStyles.labelLarge),
                Text('${booking.date.toFullDate} · ${booking.time}', style: AppTextStyles.caption),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
        ],
      ),
    );
  }
}
