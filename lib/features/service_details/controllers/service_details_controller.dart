import 'package:get/get.dart';

import '../../../core/controllers/favorites_controller.dart';
import '../../../data/mock/mock_data.dart';
import '../../../data/models/provider_model.dart';
import '../../../data/models/review_model.dart';
import '../../../data/models/service_model.dart';
import '../../../routes/app_routes.dart';

class ServiceDetailsController extends GetxController {
  late final String serviceId;
  late final ServiceModel service;
  late final ProviderModel provider;

  @override
  void onInit() {
    super.onInit();
    serviceId = Get.arguments as String;
    service = MockData.serviceById(serviceId);
    provider = MockData.providerById(service.providerId);
  }

  List<ReviewModel> get reviews => MockData.reviewsByProvider(provider.id).where((r) => r.serviceId == service.id).toList();

  bool get isFavorite => Get.find<FavoritesController>().isFavorite(service.id);
  void toggleFavorite() => Get.find<FavoritesController>().toggle(service.id);

  void openProvider() => Get.toNamed(AppRoutes.providerDetails, arguments: provider.id);

  void bookNow() => Get.toNamed(AppRoutes.booking, arguments: service.id);
}
