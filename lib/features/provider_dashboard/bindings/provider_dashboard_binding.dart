import 'package:get/get.dart';

import '../../booking_requests/controllers/booking_requests_controller.dart';
import '../../earnings/controllers/earnings_controller.dart';
import '../../provider_reviews/controllers/provider_reviews_controller.dart';
import '../../provider_services/controllers/provider_services_controller.dart';
import '../controllers/provider_dashboard_controller.dart';
import '../controllers/provider_nav_controller.dart';

/// Registers every controller the provider-mode shell and its tabs need.
/// Put (not lazyPut) so state (e.g. edited services) survives tab switches.
class ProviderDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProviderNavController());
    Get.put(ProviderServicesController());
    Get.put(BookingRequestsController());
    Get.put(EarningsController());
    Get.put(ProviderReviewsController());
    Get.put(ProviderDashboardController());
  }
}
