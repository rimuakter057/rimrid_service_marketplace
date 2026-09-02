import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg, vertical: AppSizes.sm),
                child: TextButton(
                  onPressed: controller.finish,
                  child: Text('Skip', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.pages.length,
                itemBuilder: (context, index) {
                  final page = controller.pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.xl),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 220,
                          height: 220,
                          decoration: const BoxDecoration(color: AppColors.primarySurface, shape: BoxShape.circle),
                          child: Icon(page.icon, size: 92, color: AppColors.primary),
                        ),
                        const SizedBox(height: AppSizes.xxl),
                        Text(page.title, style: AppTextStyles.h2, textAlign: TextAlign.center),
                        const SizedBox(height: AppSizes.sm),
                        Text(
                          page.description,
                          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: controller.currentPage.value == index ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index ? AppColors.primary : AppColors.border,
                      borderRadius: BorderRadius.circular(AppSizes.radiusPill),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.xl),
              child: Obx(
                () => CustomButton(
                  label: controller.isLastPage ? 'Get Started' : 'Next',
                  onPressed: controller.next,
                  icon: controller.isLastPage ? null : Icons.arrow_forward_rounded,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
