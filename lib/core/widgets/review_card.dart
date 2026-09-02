import 'package:flutter/material.dart';

import '../../core/utils/extensions.dart';
import '../../data/models/review_model.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';
import 'network_avatar.dart';
import 'rating_widget.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              NetworkAvatar(seed: review.avatarSeed, radius: 18),
              const SizedBox(width: AppSizes.xs),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.userName, style: AppTextStyles.labelLarge),
                    Text(review.date.toDayMonth, style: AppTextStyles.caption),
                  ],
                ),
              ),
              RatingWidget(rating: review.rating, size: 14),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          Text(review.comment, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
