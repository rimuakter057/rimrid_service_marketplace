import 'package:get/get.dart';

import '../controllers/add_edit_service_controller.dart';

class AddEditServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddEditServiceController());
  }
}
