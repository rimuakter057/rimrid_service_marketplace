import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../core/widgets/booking_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/models/booking_model.dart';
import '../../../routes/app_routes.dart';
import '../controllers/my_bookings_controller.dart';

class MyBookingsView extends GetView<MyBookingsController> {
  const MyBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.horizontalPadding(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ResponsiveHelper.contentMaxWidth(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(hPad, AppSizes.md, hPad, 0),
                  child: Text('My Bookings', style: AppTextStyles.h2),
                ),
                TabBar(
                  controller: controller.tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.primary,
                  labelStyle: AppTextStyles.labelMedium,
                  tabs: const [Tab(text: 'Upcoming'), Tab(text: 'History')],
                ),
                Expanded(
                  child: Obx(
                    () => TabBarView(
                      controller: controller.tabController,
                      children: [
                        _BookingList(bookings: controller.bookings.upcoming, hPad: hPad, onTap: controller.openBooking),
                        _BookingList(bookings: controller.bookings.history, hPad: hPad, onTap: controller.openBooking),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BookingList extends StatelessWidget {
  final List<BookingModel> bookings;
  final double hPad;
  final ValueChanged<BookingModel> onTap;

  const _BookingList({required this.bookings, required this.hPad, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return EmptyState(
        icon: Icons.event_note_rounded,
        title: 'Nothing here yet',
        message: 'Your bookings will show up here once you make a reservation.',
        actionLabel: 'Explore services',
        onAction: () => Get.toNamed(AppRoutes.search),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppSizes.md),
      itemCount: bookings.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSizes.sm),
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return BookingCard(booking: booking, onTap: () => onTap(booking));
      },
    );
  }
}
