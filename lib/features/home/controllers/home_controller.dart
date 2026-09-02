import 'package:get/get.dart';

import '../../../core/controllers/auth_controller.dart';
import '../../../data/mock/mock_data.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/provider_model.dart';
import '../../../data/models/service_model.dart';
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  List<CategoryModel> get categories => MockData.categories;
  List<ServiceModel> get popularServices => MockData.popularServices;
  List<ProviderModel> get topProviders =>
      (List<ProviderModel>.from(MockData.providers)..sort((a, b) => b.rating.compareTo(a.rating))).take(6).toList();

  String get userFirstName {
    final auth = Get.find<AuthController>();
    final name = auth.user.value?.name ?? MockData.currentUser.name;
    return name.split(' ').first;
  }

  final RxInt bannerIndex = 0.obs;

  void openSearch() => Get.toNamed(AppRoutes.search);

  void openCategory(CategoryModel category) {
    Get.toNamed(AppRoutes.search, arguments: {'categoryId': category.id});
  }

  void openService(ServiceModel service) {
    Get.toNamed(AppRoutes.serviceDetails, arguments: service.id);
  }

  void openProvider(ProviderModel provider) {
    Get.toNamed(AppRoutes.providerDetails, arguments: provider.id);
  }

  void openNotifications() => Get.toNamed(AppRoutes.notifications);
}
