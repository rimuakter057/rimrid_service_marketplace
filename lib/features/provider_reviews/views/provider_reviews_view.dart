import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/rating_widget.dart';
import '../../../core/widgets/review_card.dart';
import '../controllers/provider_reviews_controller.dart';

class ProviderReviewsView extends GetView<ProviderReviewsController> {
  const ProviderReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Reviews'),
      body: controller.reviews.isEmpty
          ? const EmptyState(icon: Icons.star_border_rounded, title: 'No reviews yet', message: 'Customer reviews will appear here after completed bookings.')
          : ListView(
              padding: const EdgeInsets.all(AppSizes.lg),
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                    boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(controller.averageRating.toStringAsFixed(1), style: AppTextStyles.h1.copyWith(color: AppColors.primary)),
                          RatingWidget(rating: controller.averageRating, showValue: false, size: 16),
                          const SizedBox(height: 2),
                          Text('${controller.reviews.length} reviews', style: AppTextStyles.caption),
                        ],
                      ),
                      const SizedBox(width: AppSizes.lg),
                      Expanded(
                        child: Column(
                          children: List.generate(5, (i) {
                            final star = 5 - i;
                            final count = controller.ratingBreakdown[star] ?? 0;
                            final total = controller.reviews.length;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                children: [
                                  Text('$star', style: AppTextStyles.caption),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: LinearPercentIndicator(
                                      lineHeight: 6,
                                      percent: total == 0 ? 0 : count / total,
                                      backgroundColor: AppColors.surfaceAlt,
                                      progressColor: AppColors.star,
                                      barRadius: const Radius.circular(4),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.lg),
                ...controller.reviews.map((r) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSizes.sm),
                      child: ReviewCard(review: r),
                    )),
              ],
            ),
    );
  }
}
