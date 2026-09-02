import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color background;

  const StatusBadge({super.key, required this.label, required this.color, required this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.xs, vertical: 4),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(AppSizes.radiusPill)),
      child: Text(label, style: AppTextStyles.labelSmall.copyWith(color: color)),
    );
  }
}
