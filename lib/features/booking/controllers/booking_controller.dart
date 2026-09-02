import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controllers/bookings_controller.dart';
import '../../../data/mock/mock_data.dart';
import '../../../data/models/booking_model.dart';
import '../../../data/models/provider_model.dart';
import '../../../data/models/service_model.dart';
import '../../../routes/app_routes.dart';

const List<String> kTimeSlots = [
  '8:00 AM', '9:00 AM', '10:00 AM', '11:00 AM',
  '1:00 PM', '2:00 PM', '3:00 PM', '4:00 PM', '5:00 PM',
];

class BookingController extends GetxController {
  late final ServiceModel service;
  late final ProviderModel provider;

  final Rx<DateTime> selectedDate = DateTime.now().add(const Duration(days: 1)).obs;
  final RxnString selectedTime = RxnString();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final RxInt paymentMethodIndex = 0.obs;
  final RxBool isSubmitting = false.obs;

  final List<String> paymentMethods = const ['Visa •••• 4291', 'Mastercard •••• 7723', 'Cash on service'];

  @override
  void onInit() {
    super.onInit();
    final serviceId = Get.arguments as String;
    service = MockData.serviceById(serviceId);
    provider = MockData.providerById(service.providerId);
    addressController.text = MockData.currentUser.address;
  }

  @override
  void onClose() {
    addressController.dispose();
    noteController.dispose();
    super.onClose();
  }

  void selectDate(DateTime date) => selectedDate.value = date;
  void selectTime(String time) => selectedTime.value = time;
  void selectPaymentMethod(int index) => paymentMethodIndex.value = index;

  bool get canConfirm => selectedTime.value != null && addressController.text.trim().isNotEmpty;

  Future<void> confirmBooking() async {
    if (!canConfirm) {
      Get.snackbar('Almost done', 'Please choose a time slot and confirm your address.');
      return;
    }
    isSubmitting.value = true;
    await Future.delayed(const Duration(milliseconds: 900));

    final booking = BookingModel(
      id: 'b${DateTime.now().millisecondsSinceEpoch}',
      serviceId: service.id,
      serviceTitle: service.title,
      categoryName: service.categoryName,
      providerId: provider.id,
      providerName: provider.name,
      providerAvatarSeed: provider.avatarSeed,
      date: selectedDate.value,
      time: selectedTime.value!,
      address: addressController.text.trim(),
      price: service.price,
      status: BookingStatus.pending,
      paymentMethod: paymentMethods[paymentMethodIndex.value],
      note: noteController.text.trim().isEmpty ? null : noteController.text.trim(),
    );

    Get.find<BookingsController>().addBooking(booking);
    isSubmitting.value = false;
    Get.offNamed(AppRoutes.bookingConfirmation, arguments: booking);
  }
}
