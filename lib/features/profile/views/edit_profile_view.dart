import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/network_avatar.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Edit Profile'),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.lg),
        children: [
          Center(
            child: Stack(
              children: [
                NetworkAvatar(seed: controller.auth.user.value?.avatarSeed ?? 12, radius: 48),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.xl),
          CustomTextField(
            controller: controller.nameController,
            label: 'Full name',
            prefixIcon: Icons.person_outline_rounded,
            validator: (v) => Validators.required(v, field: 'Name'),
          ),
          const SizedBox(height: AppSizes.md),
          CustomTextField(
            controller: controller.emailController,
            label: 'Email',
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.email,
          ),
          const SizedBox(height: AppSizes.md),
          CustomTextField(
            controller: controller.phoneController,
            label: 'Phone',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: Validators.phone,
          ),
          const SizedBox(height: AppSizes.md),
          CustomTextField(
            controller: controller.addressController,
            label: 'Address',
            prefixIcon: Icons.location_on_outlined,
            maxLines: 2,
            validator: (v) => Validators.required(v, field: 'Address'),
          ),
          const SizedBox(height: AppSizes.xl),
          Obx(() => CustomButton(label: 'Save Changes', isLoading: controller.isSaving.value, onPressed: controller.save)),
        ],
      ),
    );
  }
}
