import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/service_card.dart';
import '../../../data/mock/mock_data.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchFilterController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ResponsiveHelper.contentMaxWidth(context)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(hPad, AppSizes.sm, hPad, AppSizes.xs),
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
                      const SizedBox(width: AppSizes.sm),
                      Expanded(
                        child: Container(
                          height: 46,
                          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                          decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
                          child: Row(
                            children: [
                              const Icon(Icons.search_rounded, color: AppColors.textSecondary, size: 20),
                              const SizedBox(width: AppSizes.xs),
                              Expanded(
                                child: TextField(
                                  controller: controller.queryController,
                                  onChanged: controller.setQuery,
                                  autofocus: false,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search services...',
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.sm),
                      GestureDetector(
                        onTap: controller.toggleFilters,
                        child: Container(
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
                          child: const Icon(Icons.tune_rounded, color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => controller.showFilters.value ? _FilterPanel(controller: controller, hPad: hPad) : const SizedBox.shrink()),
                Expanded(
                  child: Obx(() {
                    final results = controller.results;
                    if (results.isEmpty) {
                      return const EmptyState(
                        icon: Icons.search_off_rounded,
                        title: 'No results found',
                        message: 'Try adjusting your search or filters to find what you\'re looking for.',
                      );
                    }
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSizes.sm),
                      itemCount: results.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveHelper.gridColumns(context),
                        mainAxisSpacing: AppSizes.sm,
                        crossAxisSpacing: AppSizes.sm,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        final service = results[index];
                        return ServiceCard(service: service, onTap: () => controller.openService(service));
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

class _FilterPanel extends StatelessWidget {
  final SearchFilterController controller;
  final double hPad;

  const _FilterPanel({required this.controller, required this.hPad});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(hPad, AppSizes.sm, hPad, 0),
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Filters', style: AppTextStyles.h4),
              GestureDetector(
                onTap: controller.resetFilters,
                child: Text('Reset', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          Text('Category', style: AppTextStyles.labelMedium),
          const SizedBox(height: AppSizes.xs),
          Obx(
            () => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: MockData.categories.map((c) {
                final selected = controller.selectedCategoryId.value == c.id;
                return ChoiceChip(
                  label: Text(c.name),
                  selected: selected,
                  onSelected: (_) => controller.selectCategory(c.id),
                  selectedColor: AppColors.primary,
                  labelStyle: AppTextStyles.labelSmall.copyWith(color: selected ? Colors.white : AppColors.textPrimary),
                  backgroundColor: AppColors.surfaceAlt,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusPill), side: BorderSide.none),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSizes.md),
          Obx(
            () => Text('Max price: \$${controller.maxPrice.value.toStringAsFixed(0)}', style: AppTextStyles.labelMedium),
          ),
          Obx(
            () => Slider(
              value: controller.maxPrice.value,
              min: 20,
              max: 400,
              divisions: 38,
              activeColor: AppColors.primary,
              onChanged: controller.setMaxPrice,
            ),
          ),
          Obx(
            () => Text('Minimum rating: ${controller.minRating.value.toStringAsFixed(1)}+', style: AppTextStyles.labelMedium),
          ),
          Obx(
            () => Slider(
              value: controller.minRating.value,
              min: 0,
              max: 5,
              divisions: 10,
              activeColor: AppColors.primary,
              onChanged: controller.setMinRating,
            ),
          ),
          const SizedBox(height: AppSizes.xs),
          Text('Sort by', style: AppTextStyles.labelMedium),
          const SizedBox(height: AppSizes.xs),
          Obx(
            () => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: SortOption.values.map((option) {
                final selected = controller.sortOption.value == option;
                return ChoiceChip(
                  label: Text(option.label),
                  selected: selected,
                  onSelected: (_) => controller.setSort(option),
                  selectedColor: AppColors.primary,
                  labelStyle: AppTextStyles.labelSmall.copyWith(color: selected ? Colors.white : AppColors.textPrimary),
                  backgroundColor: AppColors.surfaceAlt,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusPill), side: BorderSide.none),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
