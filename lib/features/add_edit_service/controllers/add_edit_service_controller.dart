import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/mock/mock_data.dart';
import '../../../data/models/service_model.dart';
import '../../provider_services/controllers/provider_services_controller.dart';

class AddEditServiceController extends GetxController {
  ServiceModel? editingService;
  bool get isEditing => editingService != null;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final durationController = TextEditingController();
  final descriptionController = TextEditingController();
  final tagsController = TextEditingController();

  final Rx<PriceUnit> priceUnit = PriceUnit.hour.obs;
  final RxString categoryId = MockData.categories.first.id.obs;
  final RxBool isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is ServiceModel) {
      editingService = arg;
      titleController.text = arg.title;
      priceController.text = arg.price.toStringAsFixed(arg.price.truncateToDouble() == arg.price ? 0 : 2);
      durationController.text = arg.duration;
      descriptionController.text = arg.description;
      tagsController.text = arg.tags.join(', ');
      priceUnit.value = arg.priceUnit;
      categoryId.value = arg.categoryId;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    priceController.dispose();
    durationController.dispose();
    descriptionController.dispose();
    tagsController.dispose();
    super.onClose();
  }

  void selectCategory(String id) => categoryId.value = id;
  void selectPriceUnit(PriceUnit unit) => priceUnit.value = unit;

  Future<void> save() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    isSaving.value = true;
    await Future.delayed(const Duration(milliseconds: 700));

    final category = MockData.categoryById(categoryId.value);
    final service = ServiceModel(
      id: editingService?.id ?? 's-new-${DateTime.now().millisecondsSinceEpoch}',
      title: titleController.text.trim(),
      categoryId: category.id,
      categoryName: category.name,
      providerId: kMyProviderId,
      price: double.tryParse(priceController.text.trim()) ?? 0,
      priceUnit: priceUnit.value,
      rating: editingService?.rating ?? 5.0,
      reviewCount: editingService?.reviewCount ?? 0,
      imageSeed: editingService?.imageSeed ?? 'svc-new-${DateTime.now().millisecondsSinceEpoch}',
      description: descriptionController.text.trim(),
      tags: tagsController.text.split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList(),
      duration: durationController.text.trim(),
      location: editingService?.location ?? MockData.providerById(kMyProviderId).location,
      isPopular: editingService?.isPopular ?? false,
    );

    Get.find<ProviderServicesController>().addOrUpdate(service);
    isSaving.value = false;
    Get.back();
    Get.snackbar(isEditing ? 'Service updated' : 'Service added', '"${service.title}" is now live.');
  }
}
