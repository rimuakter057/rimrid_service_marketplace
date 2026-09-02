import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/models/service_model.dart';
import '../controllers/provider_services_controller.dart';

class ProviderServicesView extends GetView<ProviderServicesController> {
  const ProviderServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSizes.lg, AppSizes.md, AppSizes.lg, AppSizes.sm),
              child: Row(
                children: [
                  Text('My Services', style: AppTextStyles.h2),
                  const Spacer(),
                  GestureDetector(
                    onTap: controller.openAddService,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: 10),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
                      child: Row(
                        children: [
                          const Icon(Icons.add_rounded, color: Colors.white, size: 18),
                          const SizedBox(width: 4),
                          Text('Add', style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final services = controller.myServices;
                if (services.isEmpty) {
                  return EmptyState(
                    icon: Icons.design_services_outlined,
                    title: 'No services yet',
                    message: 'Add your first service so customers can start booking you.',
                    actionLabel: 'Add Service',
                    onAction: controller.openAddService,
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(AppSizes.lg, 0, AppSizes.lg, AppSizes.lg),
                  itemCount: services.length,
                  separatorBuilder: (_, __) => const SizedBox(height: AppSizes.sm),
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return _ServiceManageCard(
                      service: service,
                      onEdit: () => controller.openEditService(service),
                      onDelete: () => controller.removeService(service.id),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceManageCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ServiceManageCard({required this.service, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service.title, style: AppTextStyles.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(service.categoryName, style: AppTextStyles.caption),
                const SizedBox(height: 6),
                Text(
                  '\$${service.price.toStringAsFixed(0)}${service.priceUnit.label}',
                  style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          IconButton(onPressed: onEdit, icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary)),
          IconButton(
            onPressed: () => Get.defaultDialog(
              title: 'Remove service',
              middleText: 'Remove "${service.title}" from your listings?',
              textConfirm: 'Remove',
              textCancel: 'Cancel',
              confirmTextColor: Colors.white,
              onConfirm: () {
                onDelete();
                Get.back();
              },
            ),
            icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
          ),
        ],
      ),
    );
  }
}
