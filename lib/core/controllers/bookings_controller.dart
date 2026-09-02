import 'package:get/get.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/booking_model.dart';

/// App-wide bookings state (customer side). Provider-side booking requests
/// reuse the same list, filtered/mutated from the provider dashboard.
class BookingsController extends GetxController {
  final RxList<BookingModel> bookings = <BookingModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    bookings.assignAll(MockData.bookings);
  }

  List<BookingModel> get upcoming =>
      bookings.where((b) => b.status == BookingStatus.upcoming || b.status == BookingStatus.pending).toList()
        ..sort((a, b) => a.date.compareTo(b.date));

  List<BookingModel> get history =>
      bookings.where((b) => b.status == BookingStatus.completed || b.status == BookingStatus.cancelled).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

  BookingModel byId(String id) => bookings.firstWhere((b) => b.id == id);

  void addBooking(BookingModel booking) => bookings.insert(0, booking);

  void updateStatus(String id, BookingStatus status) {
    final index = bookings.indexWhere((b) => b.id == id);
    if (index != -1) {
      bookings[index] = bookings[index].copyWith(status: status);
    }
  }
}
