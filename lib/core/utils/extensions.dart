import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringCasingExtension on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

extension DateFormatting on DateTime {
  String get toDayMonth => DateFormat('d MMM').format(this);
  String get toFullDate => DateFormat('EEE, d MMM yyyy').format(this);
  String get toTime => DateFormat('h:mm a').format(this);
  String get toDayMonthTime => DateFormat('d MMM, h:mm a').format(this);
}

extension DoubleFormatting on double {
  String get asCurrency => '\$${toStringAsFixed(2)}';
  String get asRating => toStringAsFixed(1);
}

extension ContextExtension on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);
}
