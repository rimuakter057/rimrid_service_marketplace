import 'package:get/get.dart';

import '../../../data/mock/mock_data.dart';
import '../../../data/models/category_model.dart';
import '../../../routes/app_routes.dart';

class CategoriesController extends GetxController {
  List<CategoryModel> get categories => MockData.categories;

  void openCategory(CategoryModel category) {
    Get.toNamed(AppRoutes.search, arguments: {'categoryId': category.id});
  }
}
