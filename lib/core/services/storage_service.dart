import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around SharedPreferences for the few bits of local state
/// this mock-data app needs to persist across launches (onboarding seen).
class StorageService {
  StorageService._();
  static late final SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const _kOnboardingSeen = 'onboarding_seen';

  static bool get hasSeenOnboarding => _prefs.getBool(_kOnboardingSeen) ?? false;
  static Future<void> setOnboardingSeen() => _prefs.setBool(_kOnboardingSeen, true);
}
