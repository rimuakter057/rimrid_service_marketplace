import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/mock/mock_data.dart';
import '../../../data/models/service_model.dart';
import '../../../routes/app_routes.dart';

enum SortOption { relevance, priceLowHigh, priceHighLow, rating }

extension SortOptionLabel on SortOption {
  String get label {
    switch (this) {
      case SortOption.relevance:
        return 'Relevance';
      case SortOption.priceLowHigh:
        return 'Price: Low to High';
      case SortOption.priceHighLow:
        return 'Price: High to Low';
      case SortOption.rating:
        return 'Highest Rated';
    }
  }
}

class SearchFilterController extends GetxController {
  final TextEditingController queryController = TextEditingController();
  final RxString query = ''.obs;
  final RxnString selectedCategoryId = RxnString();
  final RxDouble maxPrice = 400.0.obs;
  final RxDouble minRating = 0.0.obs;
  final Rx<SortOption> sortOption = SortOption.relevance.obs;
  final RxBool showFilters = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map && args['categoryId'] != null) {
      selectedCategoryId.value = args['categoryId'] as String;
    }
  }

  @override
  void onClose() {
    queryController.dispose();
    super.onClose();
  }

  List<ServiceModel> get results {
    var list = MockData.services.where((s) {
      final matchesQuery = query.value.isEmpty || s.title.toLowerCase().contains(query.value.toLowerCase());
      final matchesCategory = selectedCategoryId.value == null || s.categoryId == selectedCategoryId.value;
      final matchesPrice = s.price <= maxPrice.value;
      final matchesRating = s.rating >= minRating.value;
      return matchesQuery && matchesCategory && matchesPrice && matchesRating;
    }).toList();

    switch (sortOption.value) {
      case SortOption.priceLowHigh:
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighLow:
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.rating:
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortOption.relevance:
        break;
    }
    return list;
  }

  void setQuery(String value) => query.value = value;

  void selectCategory(String? id) {
    selectedCategoryId.value = selectedCategoryId.value == id ? null : id;
  }

  void setMaxPrice(double value) => maxPrice.value = value;
  void setMinRating(double value) => minRating.value = value;
  void setSort(SortOption option) => sortOption.value = option;
  void toggleFilters() => showFilters.value = !showFilters.value;

  void resetFilters() {
    selectedCategoryId.value = null;
    maxPrice.value = 400;
    minRating.value = 0;
    sortOption.value = SortOption.relevance;
  }

  void openService(ServiceModel service) {
    Get.toNamed(AppRoutes.serviceDetails, arguments: service.id);
  }
}
