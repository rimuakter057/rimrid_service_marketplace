import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../constants/app_colors.dart';

class NetworkAvatar extends StatelessWidget {
  final int seed;
  final double radius;
  final bool isOnline;

  const NetworkAvatar({super.key, required this.seed, this.radius = 24, this.isOnline = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: AppAssets.avatar(seed),
            width: radius * 2,
            height: radius * 2,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(color: AppColors.surfaceAlt),
            errorWidget: (_, __, ___) => Container(
              color: AppColors.surfaceAlt,
              child: Icon(Icons.person_rounded, color: AppColors.textHint, size: radius),
            ),
          ),
        ),
        if (isOnline)
          Positioned(
            right: -1,
            bottom: -1,
            child: Container(
              width: radius * 0.42,
              height: radius * 0.42,
              decoration: BoxDecoration(
                color: AppColors.online,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surface, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
