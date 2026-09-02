/// Placeholder endpoint map for when this app is wired up to a real backend.
/// Not called anywhere yet — the app currently runs entirely on mock data.
class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://api.rimrid.example.com/v1';

  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String services = '/services';
  static const String providers = '/providers';
  static const String categories = '/categories';
  static const String bookings = '/bookings';
  static const String reviews = '/reviews';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
}
