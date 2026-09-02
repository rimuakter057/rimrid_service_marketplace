import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

/// MediaQuery/LayoutBuilder based responsive helper — no ScreenUtil.
class ResponsiveHelper {
  ResponsiveHelper._();

  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1024;

  static DeviceType deviceType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= tabletMaxWidth) return DeviceType.desktop;
    if (width >= mobileMaxWidth) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  static bool isMobile(BuildContext context) => deviceType(context) == DeviceType.mobile;
  static bool isTablet(BuildContext context) => deviceType(context) == DeviceType.tablet;
  static bool isDesktop(BuildContext context) => deviceType(context) == DeviceType.desktop;

  static double screenWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
  static double screenHeight(BuildContext context) => MediaQuery.sizeOf(context).height;

  /// Number of grid columns to use for card grids depending on width.
  static int gridColumns(BuildContext context) {
    switch (deviceType(context)) {
      case DeviceType.mobile:
        return 2;
      case DeviceType.tablet:
        return 3;
      case DeviceType.desktop:
        return 4;
    }
  }

  /// Horizontal page padding that grows slightly on larger screens.
  static double horizontalPadding(BuildContext context) {
    switch (deviceType(context)) {
      case DeviceType.mobile:
        return 20;
      case DeviceType.tablet:
        return 40;
      case DeviceType.desktop:
        return 80;
    }
  }

  /// Clamp content to a comfortable max width on large screens.
  static double contentMaxWidth(BuildContext context) {
    switch (deviceType(context)) {
      case DeviceType.mobile:
        return double.infinity;
      case DeviceType.tablet:
        return 720;
      case DeviceType.desktop:
        return 1080;
    }
  }

  static double fontScale(BuildContext context) {
    switch (deviceType(context)) {
      case DeviceType.mobile:
        return 1.0;
      case DeviceType.tablet:
        return 1.05;
      case DeviceType.desktop:
        return 1.1;
    }
  }

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    switch (deviceType(context)) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}
