import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/controllers/auth_controller.dart';
import '../../../core/controllers/notifications_controller.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/category_card.dart';
import '../../../core/widgets/network_avatar.dart';
import '../../../core/widgets/provider_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/service_card.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    final auth = Get.find<AuthController>();
    final notifications = Get.find<NotificationsController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ResponsiveHelper.contentMaxWidth(context)),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSizes.md),
              children: [
                Row(
                  children: [
                    Obx(() => NetworkAvatar(seed: auth.user.value?.avatarSeed ?? 12, radius: 22)),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome back 👋', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                          Text(controller.userFirstName, style: AppTextStyles.h4),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.openNotifications,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSizes.radiusMd), boxShadow: [
                              BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: const Offset(0, 4)),
                            ]),
                            child: const Icon(Icons.notifications_none_rounded, size: 22),
                          ),
                          Obx(() {
                            final count = notifications.unreadCount;
                            if (count == 0) return const SizedBox.shrink();
                            return Positioned(
                              right: -2,
                              top: -2,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                                child: Text('$count', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w700)),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.lg),
                GestureDetector(
                  onTap: controller.openSearch,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                    decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
                    child: Row(
                      children: [
                        const Icon(Icons.search_rounded, color: AppColors.textSecondary),
                        const SizedBox(width: AppSizes.xs),
                        Text('Search for a service...', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
                          child: const Icon(Icons.tune_rounded, color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.xl),
                Container(
                  padding: const EdgeInsets.all(AppSizes.lg),
                  decoration: BoxDecoration(gradient: AppColors.heroGradient, borderRadius: BorderRadius.circular(AppSizes.radiusXl)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('20% OFF', style: AppTextStyles.h2.copyWith(color: Colors.white)),
                            const SizedBox(height: 4),
                            Text('On your first booking this week', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white.withValues(alpha: 0.9))),
                            const SizedBox(height: AppSizes.sm),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: 6),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppSizes.radiusPill)),
                              child: Text('Book now', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.local_offer_rounded, color: Colors.white, size: 56),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.xl),
                const SectionHeader(title: 'Categories'),
                const SizedBox(height: AppSizes.sm),
                SizedBox(
                  height: 96,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: AppSizes.sm),
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return CategoryCard(category: category, onTap: () => controller.openCategory(category));
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.xl),
                SectionHeader(title: 'Popular Services', actionLabel: 'See all', onAction: controller.openSearch),
                const SizedBox(height: AppSizes.sm),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.popularServices.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveHelper.gridColumns(context),
                    mainAxisSpacing: AppSizes.sm,
                    crossAxisSpacing: AppSizes.sm,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final service = controller.popularServices[index];
                    return ServiceCard(service: service, onTap: () => controller.openService(service));
                  },
                ),
                const SizedBox(height: AppSizes.xl),
                const SectionHeader(title: 'Top Rated Providers'),
                const SizedBox(height: AppSizes.sm),
                SizedBox(
                  height: 168,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.topProviders.length,
                    separatorBuilder: (_, __) => const SizedBox(width: AppSizes.sm),
                    itemBuilder: (context, index) {
                      final provider = controller.topProviders[index];
                      return ProviderCard(provider: provider, onTap: () => controller.openProvider(provider));
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
