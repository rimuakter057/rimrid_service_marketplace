import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/controllers/favorites_controller.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/service_card.dart';
import '../../../routes/app_routes.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Get.find<FavoritesController>();
    final hPad = ResponsiveHelper.horizontalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ResponsiveHelper.contentMaxWidth(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(hPad, AppSizes.md, hPad, AppSizes.sm),
                  child: Text('Favorites', style: AppTextStyles.h2),
                ),
                Expanded(
                  child: Obx(() {
                    final services = favorites.favoriteServices;
                    if (services.isEmpty) {
                      return EmptyState(
                        icon: Icons.favorite_border_rounded,
                        title: 'No favorites yet',
                        message: 'Tap the heart icon on any service to save it here for quick access.',
                        actionLabel: 'Browse services',
                        onAction: () => Get.toNamed(AppRoutes.search),
                      );
                    }
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSizes.sm),
                      itemCount: services.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveHelper.gridColumns(context),
                        mainAxisSpacing: AppSizes.sm,
                        crossAxisSpacing: AppSizes.sm,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        final service = services[index];
                        return ServiceCard(
                          service: service,
                          onTap: () => Get.toNamed(AppRoutes.serviceDetails, arguments: service.id),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
