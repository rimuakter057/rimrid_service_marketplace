/// Route name constants. Kept separate from AppPages so views can reference
/// route names without importing the (heavier) pages file.
class AppRoutes {
  AppRoutes._();

  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const signup = '/signup';

  static const main = '/main';
  static const search = '/search';
  static const serviceDetails = '/service-details';
  static const providerDetails = '/provider-details';
  static const favorites = '/favorites';

  static const booking = '/booking';
  static const bookingConfirmation = '/booking-confirmation';
  static const myBookings = '/my-bookings';
  static const bookingDetails = '/booking-details';

  static const chatList = '/chat-list';
  static const chatDetail = '/chat-detail';

  static const notifications = '/notifications';
  static const profile = '/profile';
  static const editProfile = '/edit-profile';
  static const settings = '/settings';

  static const providerDashboard = '/provider-dashboard';
  static const providerServices = '/provider-services';
  static const addEditService = '/add-edit-service';
  static const bookingRequests = '/booking-requests';
  static const earnings = '/earnings';
  static const providerReviews = '/provider-reviews';
}
