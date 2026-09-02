import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/controllers/bookings_controller.dart';
import '../../../data/models/booking_model.dart';
import '../../provider_services/controllers/provider_services_controller.dart';

class EarningsController extends GetxController {
  BookingsController get bookingsController => Get.find<BookingsController>();

  static const List<String> weekdayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  List<BookingModel> get completedJobs =>
      bookingsController.bookings.where((b) => b.providerId == kMyProviderId && b.status == BookingStatus.completed).toList();

  double get totalEarnings => completedJobs.fold(0.0, (sum, b) => sum + b.price + (b.tipAmount ?? 0));

  double get thisMonthEarnings {
    final now = DateTime.now();
    return completedJobs
        .where((b) => b.date.year == now.year && b.date.month == now.month)
        .fold(0.0, (sum, b) => sum + b.price + (b.tipAmount ?? 0));
  }

  double get pendingPayout => totalEarnings * 0.2;

  DateTime get _startOfThisWeek {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return today.subtract(Duration(days: today.weekday - 1));
  }

  double _earningsOn(DateTime day) {
    return completedJobs
        .where((b) => b.date.year == day.year && b.date.month == day.month && b.date.day == day.day)
        .fold(0.0, (sum, b) => sum + b.price + (b.tipAmount ?? 0));
  }

  /// Real per-day earnings (Mon-Sun) for the week containing today, derived
  /// from actual completed bookings rather than a fixed mock array.
  List<double> get weeklyTrend =>
      List.generate(7, (i) => _earningsOn(_startOfThisWeek.add(Duration(days: i))));

  List<double> get previousWeekTrend =>
      List.generate(7, (i) => _earningsOn(_startOfThisWeek.subtract(const Duration(days: 7)).add(Duration(days: i))));

  double get weekTotal => weeklyTrend.fold(0.0, (a, b) => a + b);
  double get previousWeekTotal => previousWeekTrend.fold(0.0, (a, b) => a + b);

  /// Percentage change vs. the previous week; null when there's nothing to compare against.
  double? get weekChangePercent {
    if (previousWeekTotal == 0) return null;
    return ((weekTotal - previousWeekTotal) / previousWeekTotal) * 100;
  }

  String get weekRangeLabel {
    final start = _startOfThisWeek;
    final end = start.add(const Duration(days: 6));
    final startFmt = DateFormat(start.month == end.month ? 'd' : 'MMM d').format(start);
    final endFmt = DateFormat('MMM d').format(end);
    return '$startFmt – $endFmt';
  }

  int get todayIndex => DateTime.now().weekday - 1;
  int get peakDayIndex {
    final trend = weeklyTrend;
    var peak = 0;
    for (var i = 1; i < trend.length; i++) {
      if (trend[i] > trend[peak]) peak = i;
    }
    return peak;
  }

  int get completedCount => completedJobs.length;
  double get avgJobValue => completedCount == 0 ? 0 : totalEarnings / completedCount;
}
