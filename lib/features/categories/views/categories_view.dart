import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/category_card.dart';
import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(hPad, AppSizes.md, hPad, AppSizes.sm),
                  child: Text('Categories', style: AppTextStyles.h2),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSizes.sm),
                    itemCount: controller.categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveHelper.gridColumns(context),
                      mainAxisSpacing: AppSizes.sm,
                      crossAxisSpacing: AppSizes.sm,
                      childAspectRatio: 1.15,
                    ),
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return CategoryTile(category: category, onTap: () => controller.openCategory(category));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
