import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final int? reviewCount;
  final double size;
  final bool showValue;

  const RatingWidget({
    super.key,
    required this.rating,
    this.reviewCount,
    this.size = 15,
    this.showValue = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: AppColors.star, size: size),
        const SizedBox(width: 3),
        if (showValue)
          Text(rating.toStringAsFixed(1), style: AppTextStyles.labelMedium),
        if (reviewCount != null) ...[
          const SizedBox(width: 3),
          Text('($reviewCount)', style: AppTextStyles.caption),
        ],
      ],
    );
  }
}

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final ValueChanged<double>? onChanged;

  const RatingStars({super.key, required this.rating, this.size = 28, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < rating.floor();
        final half = !filled && i < rating;
        final icon = filled
            ? Icons.star_rounded
            : half
                ? Icons.star_half_rounded
                : Icons.star_border_rounded;
        return GestureDetector(
          onTap: onChanged == null ? null : () => onChanged!((i + 1).toDouble()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Icon(icon, color: AppColors.star, size: size),
          ),
        );
      }),
    );
  }
}
