import 'package:get/get.dart';

import '../../../core/controllers/bookings_controller.dart';
import '../../../data/models/booking_model.dart';
import '../../../routes/app_routes.dart';

class BookingDetailsController extends GetxController {
  late final String bookingId;
  BookingsController get bookingsController => Get.find<BookingsController>();

  @override
  void onInit() {
    super.onInit();
    bookingId = Get.arguments as String;
  }

  BookingModel get booking => bookingsController.byId(bookingId);

  void cancelBooking() {
    Get.defaultDialog(
      title: 'Cancel booking',
      middleText: 'Are you sure you want to cancel this booking? This cannot be undone.',
      textConfirm: 'Yes, cancel',
      textCancel: 'Keep it',
      confirmTextColor: Get.theme.colorScheme.onPrimary,
      onConfirm: () {
        bookingsController.updateStatus(bookingId, BookingStatus.cancelled);
        Get.back();
        Get.snackbar('Booking cancelled', 'Your booking has been cancelled.');
      },
    );
  }

  void messageProvider() => Get.toNamed(AppRoutes.chatDetail, arguments: 't1');

  void leaveReview() => Get.snackbar('Thanks!', 'Review flow coming soon in this preview.');
}
