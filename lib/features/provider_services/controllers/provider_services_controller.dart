import 'package:get/get.dart';

import '../../../data/mock/mock_data.dart';
import '../../../data/models/service_model.dart';
import '../../../routes/app_routes.dart';

const String kMyProviderId = 'p1';

/// Mutable, in-memory list of the logged-in provider's own services.
/// Seeded from MockData but edited independently so Add/Edit Service
/// actually reflects in the Provider Services list during this session.
class ProviderServicesController extends GetxController {
  final RxList<ServiceModel> myServices = <ServiceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    myServices.assignAll(MockData.servicesByProvider(kMyProviderId));
  }

  void addOrUpdate(ServiceModel service) {
    final index = myServices.indexWhere((s) => s.id == service.id);
    if (index == -1) {
      myServices.add(service);
    } else {
      myServices[index] = service;
    }
  }

  void removeService(String id) => myServices.removeWhere((s) => s.id == id);

  void openAddService() => Get.toNamed(AppRoutes.addEditService);

  void openEditService(ServiceModel service) => Get.toNamed(AppRoutes.addEditService, arguments: service);
}
