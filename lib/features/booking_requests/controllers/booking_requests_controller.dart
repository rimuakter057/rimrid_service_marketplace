import 'package:get/get.dart';

import '../../../core/controllers/bookings_controller.dart';
import '../../../data/models/booking_model.dart';
import '../../provider_services/controllers/provider_services_controller.dart';

class BookingRequestsController extends GetxController {
  BookingsController get bookingsController => Get.find<BookingsController>();

  List<BookingModel> get pending =>
      bookingsController.bookings.where((b) => b.providerId == kMyProviderId && b.status == BookingStatus.pending).toList();

  List<BookingModel> get upcoming =>
      bookingsController.bookings.where((b) => b.providerId == kMyProviderId && b.status == BookingStatus.upcoming).toList();

  void accept(BookingModel booking) => bookingsController.updateStatus(booking.id, BookingStatus.upcoming);
  void decline(BookingModel booking) => bookingsController.updateStatus(booking.id, BookingStatus.cancelled);
}
