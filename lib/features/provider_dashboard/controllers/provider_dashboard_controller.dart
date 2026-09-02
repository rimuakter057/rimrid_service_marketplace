import 'package:get/get.dart';

import '../../../data/mock/mock_data.dart';
import '../../../data/models/provider_model.dart';
import '../../../routes/app_routes.dart';
import '../../booking_requests/controllers/booking_requests_controller.dart';
import '../../earnings/controllers/earnings_controller.dart';
import '../../provider_reviews/controllers/provider_reviews_controller.dart';
import '../../provider_services/controllers/provider_services_controller.dart';

class ProviderDashboardController extends GetxController {
  ProviderModel get provider => MockData.providerById(kMyProviderId);

  ProviderServicesController get servicesController => Get.find<ProviderServicesController>();
  BookingRequestsController get requestsController => Get.find<BookingRequestsController>();
  EarningsController get earningsController => Get.find<EarningsController>();
  ProviderReviewsController get reviewsController => Get.find<ProviderReviewsController>();

  void openReviews() => Get.toNamed(AppRoutes.providerReviews);

  void exitProviderMode() => Get.offAllNamed(AppRoutes.main);
}
