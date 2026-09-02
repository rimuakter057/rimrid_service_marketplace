import 'package:get/get.dart';

import '../controllers/booking_confirmation_controller.dart';

class BookingConfirmationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookingConfirmationController());
  }
}
