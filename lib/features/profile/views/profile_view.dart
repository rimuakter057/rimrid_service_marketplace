import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/network_avatar.dart';
import '../../../data/mock/mock_data.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ResponsiveHelper.contentMaxWidth(context)),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSizes.md),
              children: [
                Text('Profile', style: AppTextStyles.h2),
                const SizedBox(height: AppSizes.lg),
                Obx(() {
                  final user = controller.auth.user.value ?? MockData.currentUser;
                  return Container(
                    padding: const EdgeInsets.all(AppSizes.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                      boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Row(
                      children: [
                        NetworkAvatar(seed: user.avatarSeed, radius: 32),
                        const SizedBox(width: AppSizes.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.name, style: AppTextStyles.h4),
                              const SizedBox(height: 2),
                              Text(user.email, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: controller.goToEditProfile,
                          icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: AppSizes.xl),
                _MenuSection(
                  title: 'Account',
                  items: [
                    _MenuItemData(Icons.person_outline_rounded, 'Edit Profile', controller.goToEditProfile),
                    _MenuItemData(Icons.favorite_border_rounded, 'Favorites', controller.goToFavorites),
                    _MenuItemData(Icons.chat_bubble_outline_rounded, 'Messages', controller.goToChats),
                    _MenuItemData(Icons.notifications_none_rounded, 'Notifications', controller.goToNotifications),
                  ],
                ),
                const SizedBox(height: AppSizes.lg),
                _MenuSection(
                  title: 'Business',
                  items: [
                    _MenuItemData(Icons.storefront_outlined, 'Switch to Provider Mode', controller.goToProviderDashboard),
                  ],
                ),
                const SizedBox(height: AppSizes.lg),
                _MenuSection(
                  title: 'General',
                  items: [
                    _MenuItemData(Icons.settings_outlined, 'Settings', controller.goToSettings),
                    _MenuItemData(Icons.help_outline_rounded, 'Help & Support', () => Get.snackbar('Help & Support', 'Our team is here 24/7 in the full version.')),
                  ],
                ),
                const SizedBox(height: AppSizes.lg),
                GestureDetector(
                  onTap: controller.logout,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
                    decoration: BoxDecoration(
                      color: AppColors.errorSurface,
                      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout_rounded, color: AppColors.error, size: 18),
                        const SizedBox(width: AppSizes.xs),
                        Text('Log Out', style: AppTextStyles.labelLarge.copyWith(color: AppColors.error)),
                      ],
                    ),
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

class _MenuItemData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  _MenuItemData(this.icon, this.label, this.onTap);
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<_MenuItemData> items;

  const _MenuSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.xs, left: 4),
          child: Text(title, style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Column(
                children: [
                  ListTile(
                    onTap: item.onTap,
                    leading: Icon(item.icon, color: AppColors.textPrimary, size: 22),
                    title: Text(item.label, style: AppTextStyles.bodyMedium),
                    trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
                  ),
                  if (index != items.length - 1) const Divider(height: 1, indent: 16, endIndent: 16),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
