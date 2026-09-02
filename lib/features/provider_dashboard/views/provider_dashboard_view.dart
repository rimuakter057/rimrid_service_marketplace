import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/widgets/network_avatar.dart';
import '../../../core/widgets/rating_widget.dart';
import '../../booking_requests/views/booking_requests_view.dart';
import '../../earnings/views/earnings_view.dart';
import '../../provider_services/views/provider_services_view.dart';
import '../controllers/provider_dashboard_controller.dart';
import '../controllers/provider_nav_controller.dart';

class ProviderDashboardShellView extends GetView<ProviderNavController> {
  const ProviderDashboardShellView({super.key});

  static const _tabs = [
    _DashboardOverviewTab(),
    ProviderServicesView(),
    BookingRequestsView(),
    EarningsView(),
  ];

  static const _items = [
    (icon: Icons.space_dashboard_outlined, active: Icons.space_dashboard_rounded, label: 'Dashboard'),
    (icon: Icons.design_services_outlined, active: Icons.design_services_rounded, label: 'Services'),
    (icon: Icons.inbox_outlined, active: Icons.inbox_rounded, label: 'Requests'),
    (icon: Icons.account_balance_wallet_outlined, active: Icons.account_balance_wallet_rounded, label: 'Earnings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(index: controller.tabIndex.value, children: _tabs)),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(color: AppColors.surface, boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 16, offset: const Offset(0, -4))]),
          child: SafeArea(
            child: SizedBox(
              height: 62,
              child: Row(
                children: List.generate(_items.length, (index) {
                  final item = _items[index];
                  final selected = controller.tabIndex.value == index;
                  return Expanded(
                    child: InkWell(
                      onTap: () => controller.changeTab(index),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(selected ? item.active : item.icon, color: selected ? AppColors.primary : AppColors.textHint, size: 24),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: TextStyle(fontSize: 11, fontWeight: selected ? FontWeight.w600 : FontWeight.w400, color: selected ? AppColors.primary : AppColors.textHint),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardOverviewTab extends GetView<ProviderDashboardController> {
  const _DashboardOverviewTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          final provider = controller.provider;
          final earnings = controller.earningsController;
          final pendingCount = controller.requestsController.pending.length;
          final servicesCount = controller.servicesController.myServices.length;

          return ListView(
            padding: const EdgeInsets.all(AppSizes.lg),
            children: [
              Row(
                children: [
                  NetworkAvatar(seed: provider.avatarSeed, radius: 26, isOnline: provider.isOnline),
                  const SizedBox(width: AppSizes.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome back,', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                        Text(provider.name, style: AppTextStyles.h4),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.exitProviderMode,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: 8),
                      decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(AppSizes.radiusPill)),
                      child: Text('Customer view', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textPrimary)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.lg),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSizes.lg),
                decoration: BoxDecoration(gradient: AppColors.heroGradient, borderRadius: BorderRadius.circular(AppSizes.radiusXl)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('This Month', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white.withValues(alpha: 0.85))),
                    const SizedBox(height: 4),
                    Text(earnings.thisMonthEarnings.asCurrency, style: AppTextStyles.h1.copyWith(color: Colors.white)),
                    const SizedBox(height: AppSizes.sm),
                    Row(
                      children: [
                        RatingWidget(rating: provider.rating, size: 15),
                        const SizedBox(width: AppSizes.sm),
                        Text('${provider.reviewCount} reviews', style: AppTextStyles.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.85))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.lg),
              Row(
                children: [
                  _StatTile(icon: Icons.design_services_outlined, label: 'Active Services', value: '$servicesCount', color: AppColors.info),
                  const SizedBox(width: AppSizes.sm),
                  _StatTile(icon: Icons.inbox_outlined, label: 'Pending Requests', value: '$pendingCount', color: AppColors.warning),
                ],
              ),
              const SizedBox(height: AppSizes.sm),
              Row(
                children: [
                  _StatTile(icon: Icons.task_alt_rounded, label: 'Completed Jobs', value: '${earnings.completedCount}', color: AppColors.success),
                  const SizedBox(width: AppSizes.sm),
                  _StatTile(
                    icon: Icons.star_border_rounded,
                    label: 'View Reviews',
                    value: provider.rating.toStringAsFixed(1),
                    color: AppColors.primary,
                    onTap: controller.openReviews,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.xl),
              Text('Quick tip', style: AppTextStyles.h4),
              const SizedBox(height: AppSizes.xs),
              Container(
                padding: const EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_outline_rounded, color: AppColors.primary),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(
                      child: Text(
                        'Responding to requests within 15 minutes increases your booking rate by up to 30%.',
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback? onTap;

  const _StatTile({required this.icon, required this.label, required this.value, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSizes.sm),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(height: 6),
              Text(value, style: AppTextStyles.labelLarge),
              Text(label, style: AppTextStyles.caption),
            ],
          ),
        ),
      ),
    );
  }
}
