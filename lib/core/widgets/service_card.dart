import 'package:flutter/material.dart';

import '../../data/models/service_model.dart';
import '../constants/app_assets.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';
import 'favorite_button.dart';
import 'network_image_box.dart';
import 'rating_widget.dart';

/// Vertical card used in grids (Home, Category listing, Favorites).
class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onTap;

  const ServiceCard({super.key, required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 14, offset: const Offset(0, 6))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.35,
                  child: NetworkImageBox(
                    url: AppAssets.serviceImage(service.imageSeed),
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSizes.radiusLg)),
                  ),
                ),
                Positioned(top: AppSizes.xs, right: AppSizes.xs, child: FavoriteButton(serviceId: service.id)),
                if (service.isPopular)
                  Positioned(
                    top: AppSizes.xs,
                    left: AppSizes.xs,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      ),
                      child: Text('Popular', style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    style: AppTextStyles.labelLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service.categoryName,
                    style: AppTextStyles.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingWidget(rating: service.rating, size: 14),
                      Text(
                        '\$${service.price.toStringAsFixed(service.price.truncateToDouble() == service.price ? 0 : 2)}${service.priceUnit.label}',
                        style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal list-tile style card used in Search results / category lists.
class ServiceListTile extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onTap;

  const ServiceListTile({super.key, required this.service, required this.onTap});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NetworkImageBox(
              url: AppAssets.serviceImage(service.imageSeed, width: 200, height: 200),
              width: 88,
              height: 88,
            ),
            const SizedBox(width: AppSizes.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.title, style: AppTextStyles.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 3),
                  Text(service.categoryName, style: AppTextStyles.caption),
                  const SizedBox(height: 6),
                  RatingWidget(rating: service.rating, reviewCount: service.reviewCount, size: 14),
                  const SizedBox(height: 6),
                  Text(
                    '\$${service.price.toStringAsFixed(0)}${service.priceUnit.label}',
                    style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ),
            FavoriteButton(serviceId: service.id),
          ],
        ),
      ),
    );
  }
}
