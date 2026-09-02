import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controllers/bookings_controller.dart';
import '../../../data/models/booking_model.dart';
import '../../../routes/app_routes.dart';

class MyBookingsController extends GetxController with GetTickerProviderStateMixin {
  late final TabController tabController = TabController(length: 2, vsync: this);
  BookingsController get bookings => Get.find<BookingsController>();

  void openBooking(BookingModel booking) {
    Get.toNamed(AppRoutes.bookingDetails, arguments: booking.id);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
