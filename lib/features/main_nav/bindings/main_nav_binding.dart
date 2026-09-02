import 'package:get/get.dart';

import '../../categories/controllers/categories_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../my_bookings/controllers/my_bookings_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/main_nav_controller.dart';

class MainNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainNavController());
    Get.put(HomeController());
    Get.put(CategoriesController());
    Get.put(MyBookingsController());
    Get.put(ProfileController());
  }
}
