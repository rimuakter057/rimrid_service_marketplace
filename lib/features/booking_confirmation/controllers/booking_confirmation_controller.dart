import 'package:get/get.dart';

import '../../../data/models/booking_model.dart';
import '../../../routes/app_routes.dart';

class BookingConfirmationController extends GetxController {
  late final BookingModel booking;

  @override
  void onInit() {
    super.onInit();
    booking = Get.arguments as BookingModel;
  }

  void goToMyBookings() => Get.offAllNamed(AppRoutes.main);

  void goHome() => Get.offAllNamed(AppRoutes.main);
}
