import 'package:get/get.dart';

import '../../../data/mock/mock_data.dart';
import '../../../data/models/provider_model.dart';
import '../../../data/models/review_model.dart';
import '../../../data/models/service_model.dart';
import '../../../routes/app_routes.dart';

class ProviderDetailsController extends GetxController {
  late final String providerId;
  late final ProviderModel provider;

  @override
  void onInit() {
    super.onInit();
    providerId = Get.arguments as String;
    provider = MockData.providerById(providerId);
  }

  List<ServiceModel> get services => MockData.servicesByProvider(providerId);
  List<ReviewModel> get reviews => MockData.reviewsByProvider(providerId);

  void openService(ServiceModel service) => Get.toNamed(AppRoutes.serviceDetails, arguments: service.id);

  void message() => Get.toNamed(AppRoutes.chatDetail, arguments: 't1');

  void call() => Get.snackbar('Calling', 'Voice calling isn\'t wired up in this preview yet.');
}
