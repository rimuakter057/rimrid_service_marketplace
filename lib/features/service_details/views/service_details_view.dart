import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/network_avatar.dart';
import '../../../core/widgets/network_image_box.dart';
import '../../../core/widgets/rating_widget.dart';
import '../../../core/widgets/review_card.dart';
import '../../../data/models/service_model.dart';
import '../controllers/service_details_controller.dart';

class ServiceDetailsView extends GetView<ServiceDetailsController> {
  const ServiceDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final service = controller.service;
    final provider = controller.provider;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  NetworkImageBox(
                    url: AppAssets.serviceImage(service.imageSeed, width: 900, height: 600),
                    width: double.infinity,
                    height: 280,
                    borderRadius: BorderRadius.zero,
                  ),
                  Positioned(
                    top: 50,
                    left: AppSizes.lg,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: AppSizes.lg,
                    child: GestureDetector(
                      onTap: controller.toggleFavorite,
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Icon(
                            controller.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            color: controller.isFavorite ? AppColors.primary : AppColors.textSecondary,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                transform: Matrix4.translationValues(0, -20, 0),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radiusXl)),
                ),
                padding: const EdgeInsets.all(AppSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(service.title, style: AppTextStyles.h2)),
                        Text(
                          '\$${service.price.toStringAsFixed(0)}${service.priceUnit.label}',
                          style: AppTextStyles.price,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.xs),
                    Row(
                      children: [
                        RatingWidget(rating: service.rating, reviewCount: service.reviewCount),
                        const SizedBox(width: AppSizes.sm),
                        const Icon(Icons.location_on_outlined, size: 15, color: AppColors.textSecondary),
                        const SizedBox(width: 2),
                        Expanded(child: Text(service.location, style: AppTextStyles.caption, maxLines: 1, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const SizedBox(height: AppSizes.md),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _InfoChip(icon: Icons.schedule_rounded, label: service.duration),
                        _InfoChip(icon: Icons.category_outlined, label: service.categoryName),
                        ...service.tags.map((t) => _InfoChip(icon: Icons.check_circle_outline_rounded, label: t)),
                      ],
                    ),
                    const SizedBox(height: AppSizes.lg),
                    Text('About this service', style: AppTextStyles.h4),
                    const SizedBox(height: AppSizes.xs),
                    Text(service.description, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary, height: 1.5)),
                    const SizedBox(height: AppSizes.lg),
                    Text('Service Provider', style: AppTextStyles.h4),
                    const SizedBox(height: AppSizes.sm),
                    GestureDetector(
                      onTap: controller.openProvider,
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.sm),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: const Offset(0, 4))],
                        ),
                        child: Row(
                          children: [
                            NetworkAvatar(seed: provider.avatarSeed, radius: 26, isOnline: provider.isOnline),
                            const SizedBox(width: AppSizes.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(provider.name, style: AppTextStyles.labelLarge),
                                      if (provider.isVerified) ...[
                                        const SizedBox(width: 4),
                                        const Icon(Icons.verified_rounded, color: AppColors.primary, size: 15),
                                      ],
                                    ],
                                  ),
                                  Text(provider.profession, style: AppTextStyles.caption),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Reviews', style: AppTextStyles.h4),
                        RatingWidget(rating: service.rating, reviewCount: service.reviewCount, size: 14),
                      ],
                    ),
                    const SizedBox(height: AppSizes.sm),
                    if (controller.reviews.isEmpty)
                      Text('No reviews yet for this service.', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary))
                    else
                      ...controller.reviews.map((r) => Padding(
                            padding: const EdgeInsets.only(bottom: AppSizes.sm),
                            child: ReviewCard(review: r),
                          )),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(AppSizes.lg, AppSizes.sm, AppSizes.lg, MediaQuery.paddingOf(context).bottom + AppSizes.sm),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 16, offset: const Offset(0, -4))],
              ),
              child: CustomButton(label: 'Book Now', icon: Icons.calendar_month_rounded, onPressed: controller.bookNow),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: 6),
      decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(AppSizes.radiusPill)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
