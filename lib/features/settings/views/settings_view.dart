import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Settings'),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.lg),
        children: [
          _SectionLabel('Notifications'),
          _SettingsCard(children: [
            Obx(() => _SwitchTile(icon: Icons.notifications_none_rounded, title: 'Push Notifications', value: controller.pushNotifications.value, onChanged: controller.togglePush)),
            const Divider(height: 1, indent: 52),
            Obx(() => _SwitchTile(icon: Icons.mail_outline_rounded, title: 'Email Notifications', value: controller.emailNotifications.value, onChanged: controller.toggleEmail)),
            const Divider(height: 1, indent: 52),
            Obx(() => _SwitchTile(icon: Icons.sms_outlined, title: 'SMS Notifications', value: controller.smsNotifications.value, onChanged: controller.toggleSms)),
          ]),
          const SizedBox(height: AppSizes.lg),
          _SectionLabel('Appearance'),
          _SettingsCard(children: [
            Obx(() => _SwitchTile(icon: Icons.dark_mode_outlined, title: 'Dark Mode', value: controller.darkMode.value, onChanged: controller.toggleDarkMode)),
          ]),
          const SizedBox(height: AppSizes.lg),
          _SectionLabel('Preferences'),
          _SettingsCard(children: [
            Obx(() => _NavTile(icon: Icons.language_rounded, title: 'Language', value: controller.language.value)),
            const Divider(height: 1, indent: 52),
            Obx(() => _NavTile(icon: Icons.attach_money_rounded, title: 'Currency', value: controller.currency.value)),
          ]),
          const SizedBox(height: AppSizes.lg),
          _SectionLabel('About'),
          _SettingsCard(children: [
            const _NavTile(icon: Icons.description_outlined, title: 'Terms of Service'),
            const Divider(height: 1, indent: 52),
            const _NavTile(icon: Icons.privacy_tip_outlined, title: 'Privacy Policy'),
            const Divider(height: 1, indent: 52),
            const _NavTile(icon: Icons.info_outline_rounded, title: 'App Version', value: '1.0.0'),
          ]),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.xs, left: 4),
      child: Text(label, style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(children: children),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({required this.icon, required this.title, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.primary,
      secondary: Icon(icon, color: AppColors.textPrimary),
      title: Text(title, style: AppTextStyles.bodyMedium),
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;

  const _NavTile({required this.icon, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title, style: AppTextStyles.bodyMedium),
      trailing: value != null
          ? Text(value!, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary))
          : const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
    );
  }
}
