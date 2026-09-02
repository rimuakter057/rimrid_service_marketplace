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
import '../../../core/widgets/service_card.dart';
import '../controllers/provider_details_controller.dart';

class ProviderDetailsView extends GetView<ProviderDetailsController> {
  const ProviderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = controller.provider;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSizes.lg, AppSizes.sm, AppSizes.lg, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
                    ),
                  ),
                  const Spacer(),
                  Text('Provider Profile', style: AppTextStyles.h4),
                  const Spacer(),
                  const SizedBox(width: 36),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSizes.lg),
                children: [
                  Center(
                    child: Column(
                      children: [
                        NetworkAvatar(seed: provider.avatarSeed, radius: 48, isOnline: provider.isOnline),
                        const SizedBox(height: AppSizes.sm),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(provider.name, style: AppTextStyles.h3),
                            if (provider.isVerified) ...[
                              const SizedBox(width: 6),
                              const Icon(Icons.verified_rounded, color: AppColors.primary, size: 20),
                            ],
                          ],
                        ),
                        Text(provider.profession, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                        const SizedBox(height: AppSizes.xs),
                        RatingWidget(rating: provider.rating, reviewCount: provider.reviewCount),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.lg),
                  Row(
                    children: [
                      _StatTile(label: 'Experience', value: '${provider.yearsExperience} yrs'),
                      _StatTile(label: 'Jobs done', value: '${provider.completedJobs}'),
                      _StatTile(label: 'Response', value: provider.responseTime.replaceAll('Replies in ~', '')),
                    ],
                  ),
                  const SizedBox(height: AppSizes.lg),
                  Row(
                    children: [
                      Expanded(child: CustomButton(label: 'Message', icon: Icons.chat_bubble_outline_rounded, onPressed: controller.message)),
                      const SizedBox(width: AppSizes.sm),
                      Expanded(child: CustomButton(label: 'Call', icon: Icons.call_outlined, variant: CustomButtonVariant.outlined, onPressed: controller.call)),
                    ],
                  ),
                  const SizedBox(height: AppSizes.lg),
                  Text('About', style: AppTextStyles.h4),
                  const SizedBox(height: AppSizes.xs),
                  Text(provider.bio, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary, height: 1.5)),
                  const SizedBox(height: AppSizes.lg),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(provider.location, style: AppTextStyles.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: AppSizes.lg),
                  Text('Work Gallery', style: AppTextStyles.h4),
                  const SizedBox(height: AppSizes.sm),
                  SizedBox(
                    height: 90,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.gallerySeeds.length,
                      separatorBuilder: (_, __) => const SizedBox(width: AppSizes.xs),
                      itemBuilder: (context, index) => NetworkImageBox(
                        url: AppAssets.serviceImage(provider.gallerySeeds[index], width: 300, height: 300),
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.lg),
                  Text('Services Offered', style: AppTextStyles.h4),
                  const SizedBox(height: AppSizes.sm),
                  ...controller.services.map((s) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSizes.sm),
                        child: ServiceListTile(service: s, onTap: () => controller.openService(s)),
                      )),
                  const SizedBox(height: AppSizes.lg),
                  Text('Reviews (${provider.reviewCount})', style: AppTextStyles.h4),
                  const SizedBox(height: AppSizes.sm),
                  if (controller.reviews.isEmpty)
                    Text('No reviews yet.', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary))
                  else
                    ...controller.reviews.map((r) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSizes.sm),
                          child: ReviewCard(review: r),
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;

  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSizes.radiusMd), boxShadow: [
          BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 3)),
        ]),
        child: Column(
          children: [
            Text(value, style: AppTextStyles.h4.copyWith(color: AppColors.primary)),
            const SizedBox(height: 2),
            Text(label, style: AppTextStyles.caption, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
