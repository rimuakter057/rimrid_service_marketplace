import 'package:get/get.dart';

import '../controllers/service_details_controller.dart';

class ServiceDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceDetailsController());
  }
}
