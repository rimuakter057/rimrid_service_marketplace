import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // SplashView never reads `controller` in its build method (it's a
    // static animation), so a lazyPut would never be instantiated and
    // onInit's navigation timer would never fire. Put it eagerly instead.
    Get.put(SplashController());
  }
}
