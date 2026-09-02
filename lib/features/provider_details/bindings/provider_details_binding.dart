import 'package:get/get.dart';

import '../controllers/provider_details_controller.dart';

class ProviderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProviderDetailsController());
  }
}
