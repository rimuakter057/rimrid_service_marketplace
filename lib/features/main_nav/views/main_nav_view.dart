import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../categories/views/categories_view.dart';
import '../../favorites/views/favorites_view.dart';
import '../../home/views/home_view.dart';
import '../../my_bookings/views/my_bookings_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/main_nav_controller.dart';

class MainNavView extends GetView<MainNavController> {
  const MainNavView({super.key});

  static final _tabs = [
    const HomeView(),
    const CategoriesView(),
    const FavoritesView(),
    const MyBookingsView(),
    const ProfileView(),
  ];

  static const _items = [
    (icon: Icons.home_outlined, active: Icons.home_rounded, label: 'Home'),
    (icon: Icons.grid_view_outlined, active: Icons.grid_view_rounded, label: 'Categories'),
    (icon: Icons.favorite_border_rounded, active: Icons.favorite_rounded, label: 'Favorites'),
    (icon: Icons.calendar_today_outlined, active: Icons.calendar_today_rounded, label: 'Bookings'),
    (icon: Icons.person_outline_rounded, active: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(index: controller.tabIndex.value, children: _tabs)),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 16, offset: const Offset(0, -4))],
          ),
          child: SafeArea(
            child: SizedBox(
              height: 62,
              child: Row(
                children: List.generate(_items.length, (index) {
                  final item = _items[index];
                  final selected = controller.tabIndex.value == index;
                  return Expanded(
                    child: InkWell(
                      onTap: () => controller.changeTab(index),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            selected ? item.active : item.icon,
                            color: selected ? AppColors.primary : AppColors.textHint,
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                              color: selected ? AppColors.primary : AppColors.textHint,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
