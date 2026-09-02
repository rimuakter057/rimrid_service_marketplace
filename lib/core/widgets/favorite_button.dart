import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../controllers/favorites_controller.dart';

class FavoriteButton extends StatelessWidget {
  final String serviceId;
  final double size;

  const FavoriteButton({super.key, required this.serviceId, this.size = 18});

  @override
  Widget build(BuildContext context) {
    final favorites = Get.find<FavoritesController>();
    return Obx(() {
      final isFav = favorites.isFavorite(serviceId);
      return GestureDetector(
        onTap: () => favorites.toggle(serviceId),
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 6, offset: const Offset(0, 2))],
          ),
          child: Icon(
            isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: isFav ? AppColors.primary : AppColors.textSecondary,
            size: size,
          ),
        ),
      );
    });
  }
}
