import 'package:flutter/material.dart';

import '../../data/models/provider_model.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';
import 'network_avatar.dart';
import 'rating_widget.dart';

class ProviderCard extends StatelessWidget {
  final ProviderModel provider;
  final VoidCallback onTap;

  const ProviderCard({super.key, required this.provider, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 168,
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 14, offset: const Offset(0, 6))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                NetworkAvatar(seed: provider.avatarSeed, radius: 26, isOnline: provider.isOnline),
                const Spacer(),
                if (provider.isVerified)
                  const Icon(Icons.verified_rounded, color: AppColors.primary, size: 18),
              ],
            ),
            const SizedBox(height: AppSizes.sm),
            Text(provider.name, style: AppTextStyles.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text(
              provider.profession,
              style: AppTextStyles.caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSizes.xs),
            RatingWidget(rating: provider.rating, reviewCount: provider.reviewCount, size: 14),
          ],
        ),
      ),
    );
  }
}

/// Horizontal row-style provider card, used in provider search results.
class ProviderListTile extends StatelessWidget {
  final ProviderModel provider;
  final VoidCallback onTap;

  const ProviderListTile({super.key, required this.provider, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            NetworkAvatar(seed: provider.avatarSeed, radius: 30, isOnline: provider.isOnline),
            const SizedBox(width: AppSizes.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(provider.name, style: AppTextStyles.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      if (provider.isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.verified_rounded, color: AppColors.primary, size: 15),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(provider.profession, style: AppTextStyles.caption),
                  const SizedBox(height: 6),
                  RatingWidget(rating: provider.rating, reviewCount: provider.reviewCount, size: 14),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }
}
