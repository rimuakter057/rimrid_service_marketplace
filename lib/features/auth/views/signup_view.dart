import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.background, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.xl),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create account', style: AppTextStyles.h1),
                const SizedBox(height: 6),
                Text(
                  'Sign up to start booking trusted service providers near you.',
                  style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppSizes.xxl),
                CustomTextField(
                  controller: controller.nameController,
                  label: 'Full name',
                  hint: 'Alex Morgan',
                  prefixIcon: Icons.person_outline_rounded,
                  validator: (v) => Validators.required(v, field: 'Full name'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSizes.md),
                CustomTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  hint: 'you@example.com',
                  prefixIcon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSizes.md),
                CustomTextField(
                  controller: controller.passwordController,
                  label: 'Password',
                  hint: 'At least 6 characters',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: true,
                  validator: Validators.password,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSizes.md),
                CustomTextField(
                  controller: controller.confirmPasswordController,
                  label: 'Confirm password',
                  hint: 'Re-enter your password',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: true,
                  validator: (v) => Validators.confirmPassword(v, controller.passwordController.text),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: AppSizes.md),
                Obx(
                  () => Row(
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                          value: controller.agreedToTerms.value,
                          onChanged: controller.toggleTerms,
                          activeColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                      const SizedBox(width: AppSizes.xs),
                      Expanded(
                        child: Text(
                          'I agree to the Terms of Service and Privacy Policy',
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.lg),
                Obx(
                  () => CustomButton(
                    label: 'Create Account',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.signup,
                  ),
                ),
                const SizedBox(height: AppSizes.xl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                    GestureDetector(
                      onTap: controller.goToLogin,
                      child: Text('Log In', style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary)),
                    ),
                  ],
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
