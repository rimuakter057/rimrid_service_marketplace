import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../data/mock/mock_data.dart';
import '../../../data/models/service_model.dart';
import '../controllers/add_edit_service_controller.dart';

class AddEditServiceView extends GetView<AddEditServiceController> {
  const AddEditServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: controller.isEditing ? 'Edit Service' : 'Add Service'),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.lg),
          children: [
            CustomTextField(
              controller: controller.titleController,
              label: 'Service title',
              hint: 'e.g. Deep Home Cleaning',
              prefixIcon: Icons.design_services_outlined,
              validator: (v) => Validators.required(v, field: 'Title'),
            ),
            const SizedBox(height: AppSizes.md),
            Text('Category', style: AppTextStyles.labelMedium),
            const SizedBox(height: AppSizes.xs),
            Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: MockData.categories.map((c) {
                  final selected = controller.categoryId.value == c.id;
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
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.priceController,
                    label: 'Price (\$)',
                    hint: '45',
                    prefixIcon: Icons.attach_money_rounded,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (v) => Validators.required(v, field: 'Price'),
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: CustomTextField(
                    controller: controller.durationController,
                    label: 'Duration',
                    hint: 'e.g. 2 hrs',
                    prefixIcon: Icons.schedule_rounded,
                    validator: (v) => Validators.required(v, field: 'Duration'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.md),
            Text('Price type', style: AppTextStyles.labelMedium),
            const SizedBox(height: AppSizes.xs),
            Obx(
              () => Wrap(
                spacing: 8,
                children: PriceUnit.values.map((unit) {
                  final selected = controller.priceUnit.value == unit;
                  return ChoiceChip(
                    label: Text(unit.label.trim().isEmpty ? 'Fixed' : unit.label),
                    selected: selected,
                    onSelected: (_) => controller.selectPriceUnit(unit),
                    selectedColor: AppColors.primary,
                    labelStyle: AppTextStyles.labelSmall.copyWith(color: selected ? Colors.white : AppColors.textPrimary),
                    backgroundColor: AppColors.surfaceAlt,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusPill), side: BorderSide.none),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppSizes.md),
            CustomTextField(
              controller: controller.descriptionController,
              label: 'Description',
              hint: 'Describe what\'s included in this service...',
              prefixIcon: Icons.notes_rounded,
              maxLines: 4,
              validator: (v) => Validators.required(v, field: 'Description'),
            ),
            const SizedBox(height: AppSizes.md),
            CustomTextField(
              controller: controller.tagsController,
              label: 'Tags (comma separated)',
              hint: 'Insured, Same-day, Eco-friendly',
              prefixIcon: Icons.local_offer_outlined,
            ),
            const SizedBox(height: AppSizes.xl),
            Obx(
              () => CustomButton(
                label: controller.isEditing ? 'Save Changes' : 'Publish Service',
                isLoading: controller.isSaving.value,
                onPressed: controller.save,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
