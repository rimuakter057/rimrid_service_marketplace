import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/network_avatar.dart';
import '../controllers/booking_confirmation_controller.dart';

class BookingConfirmationView extends GetView<BookingConfirmationController> {
  const BookingConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = controller.booking;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.xl),
          child: Column(
            children: [
              const Spacer(),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                builder: (context, value, child) => Transform.scale(scale: value, child: child),
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: const BoxDecoration(color: AppColors.successSurface, shape: BoxShape.circle),
                  child: const Icon(Icons.check_rounded, color: AppColors.success, size: 52),
                ),
              ),
              const SizedBox(height: AppSizes.xl),
              Text('Booking Requested!', style: AppTextStyles.h2, textAlign: TextAlign.center),
              const SizedBox(height: AppSizes.xs),
              Text(
                'Your request has been sent to ${booking.providerName}. You\'ll be notified once it\'s confirmed.',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.xl),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                  boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: const Offset(0, 4))],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        NetworkAvatar(seed: booking.providerAvatarSeed, radius: 22),
                        const SizedBox(width: AppSizes.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(booking.serviceTitle, style: AppTextStyles.labelLarge),
                              Text(booking.providerName, style: AppTextStyles.caption),
                            ],
                          ),
                        ),
                        Text('\$${booking.price.toStringAsFixed(0)}', style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary)),
                      ],
                    ),
                    const Divider(height: AppSizes.xl),
                    _Row(icon: Icons.calendar_today_rounded, label: booking.date.toFullDate),
                    const SizedBox(height: AppSizes.xs),
                    _Row(icon: Icons.access_time_rounded, label: booking.time),
                    const SizedBox(height: AppSizes.xs),
                    _Row(icon: Icons.location_on_outlined, label: booking.address),
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(label: 'View My Bookings', onPressed: controller.goToMyBookings),
              const SizedBox(height: AppSizes.sm),
              CustomButton(label: 'Back to Home', variant: CustomButtonVariant.text, onPressed: controller.goHome),
            ],
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Row({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: AppSizes.xs),
        Expanded(child: Text(label, style: AppTextStyles.bodyMedium)),
      ],
    );
  }
}
