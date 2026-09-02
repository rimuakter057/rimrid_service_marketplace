import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

enum BookingStatus { pending, upcoming, completed, cancelled }

extension BookingStatusMeta on BookingStatus {
  String get label {
    switch (this) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.upcoming:
        return 'Upcoming';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case BookingStatus.pending:
        return AppColors.warning;
      case BookingStatus.upcoming:
        return AppColors.info;
      case BookingStatus.completed:
        return AppColors.success;
      case BookingStatus.cancelled:
        return AppColors.error;
    }
  }

  Color get surfaceColor {
    switch (this) {
      case BookingStatus.pending:
        return AppColors.warningSurface;
      case BookingStatus.upcoming:
        return AppColors.infoSurface;
      case BookingStatus.completed:
        return AppColors.successSurface;
      case BookingStatus.cancelled:
        return AppColors.errorSurface;
    }
  }
}

class BookingModel {
  final String id;
  final String serviceId;
  final String serviceTitle;
  final String categoryName;
  final String providerId;
  final String providerName;
  final int providerAvatarSeed;
  final DateTime date;
  final String time;
  final String address;
  final double price;
  final BookingStatus status;
  final String paymentMethod;
  final String? note;
  final double? tipAmount;

  const BookingModel({
    required this.id,
    required this.serviceId,
    required this.serviceTitle,
    required this.categoryName,
    required this.providerId,
    required this.providerName,
    required this.providerAvatarSeed,
    required this.date,
    required this.time,
    required this.address,
    required this.price,
    required this.status,
    required this.paymentMethod,
    this.note,
    this.tipAmount,
  });

  BookingModel copyWith({BookingStatus? status}) {
    return BookingModel(
      id: id,
      serviceId: serviceId,
      serviceTitle: serviceTitle,
      categoryName: categoryName,
      providerId: providerId,
      providerName: providerName,
      providerAvatarSeed: providerAvatarSeed,
      date: date,
      time: time,
      address: address,
      price: price,
      status: status ?? this.status,
      paymentMethod: paymentMethod,
      note: note,
      tipAmount: tipAmount,
    );
  }
}
