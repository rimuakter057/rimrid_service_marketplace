import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/network_avatar.dart';
import '../../../data/models/service_model.dart';
import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Book Service'),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.lg),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.sm),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusLg),
              boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Row(
              children: [
                NetworkAvatar(seed: controller.provider.avatarSeed, radius: 26),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.service.title, style: AppTextStyles.labelLarge),
                      Text('with ${controller.provider.name}', style: AppTextStyles.caption),
                    ],
                  ),
                ),
                Text(
                  '\$${controller.service.price.toStringAsFixed(0)}${controller.service.priceUnit.label}',
                  style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          Text('Select Date', style: AppTextStyles.h4),
          const SizedBox(height: AppSizes.xs),
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.xs),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusLg),
              boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Obx(
              () => TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 90)),
                focusedDay: controller.selectedDate.value,
                calendarFormat: CalendarFormat.week,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: AppTextStyles.labelLarge,
                  leftChevronIcon: const Icon(Icons.chevron_left_rounded, color: AppColors.textSecondary),
                  rightChevronIcon: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: AppTextStyles.caption, weekendStyle: AppTextStyles.caption),
                selectedDayPredicate: (day) => isSameDay(day, controller.selectedDate.value),
                onDaySelected: (selected, focused) => controller.selectDate(selected),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  todayDecoration: BoxDecoration(color: AppColors.primarySurface, shape: BoxShape.circle),
                  todayTextStyle: const TextStyle(color: AppColors.primary),
                  selectedDecoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  defaultTextStyle: AppTextStyles.bodyMedium,
                  weekendTextStyle: AppTextStyles.bodyMedium,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          Text('Select Time', style: AppTextStyles.h4),
          const SizedBox(height: AppSizes.xs),
          Obx(
            () => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: kTimeSlots.map((slot) {
                final selected = controller.selectedTime.value == slot;
                return GestureDetector(
                  onTap: () => controller.selectTime(slot),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: AppSizes.xs),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primary : AppColors.surface,
                      borderRadius: BorderRadius.circular(AppSizes.radiusPill),
                      border: Border.all(color: selected ? AppColors.primary : AppColors.border),
                    ),
                    child: Text(
                      slot,
                      style: AppTextStyles.labelSmall.copyWith(color: selected ? Colors.white : AppColors.textPrimary),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          CustomTextField(
            controller: controller.addressController,
            label: 'Service Address',
            hint: 'Enter your address',
            prefixIcon: Icons.location_on_outlined,
          ),
          const SizedBox(height: AppSizes.md),
          CustomTextField(
            controller: controller.noteController,
            label: 'Note for provider (optional)',
            hint: 'Any special instructions...',
            prefixIcon: Icons.edit_note_rounded,
            maxLines: 3,
          ),
          const SizedBox(height: AppSizes.lg),
          Text('Payment Method', style: AppTextStyles.h4),
          const SizedBox(height: AppSizes.xs),
          Obx(
            () => Column(
              children: List.generate(controller.paymentMethods.length, (index) {
                final selected = controller.paymentMethodIndex.value == index;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.xs),
                  child: GestureDetector(
                    onTap: () => controller.selectPaymentMethod(index),
                    child: Container(
                      padding: const EdgeInsets.all(AppSizes.sm),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        border: Border.all(color: selected ? AppColors.primary : AppColors.border, width: selected ? 1.4 : 1),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            index == controller.paymentMethods.length - 1 ? Icons.payments_outlined : Icons.credit_card_rounded,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: AppSizes.sm),
                          Expanded(child: Text(controller.paymentMethods[index], style: AppTextStyles.bodyMedium)),
                          Icon(
                            selected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                            color: selected ? AppColors.primary : AppColors.textHint,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: AppSizes.xl),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(AppSizes.lg, AppSizes.sm, AppSizes.lg, MediaQuery.paddingOf(context).bottom + AppSizes.sm),
        decoration: BoxDecoration(color: AppColors.surface, boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 16, offset: const Offset(0, -4))]),
        child: Obx(
          () => CustomButton(
            label: 'Confirm Booking · \$${controller.service.price.toStringAsFixed(0)}',
            isLoading: controller.isSubmitting.value,
            onPressed: controller.confirmBooking,
          ),
        ),
      ),
    );
  }
}
