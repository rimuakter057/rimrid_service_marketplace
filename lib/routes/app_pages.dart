import 'package:get/get.dart';

import '../features/add_edit_service/bindings/add_edit_service_binding.dart';
import '../features/add_edit_service/views/add_edit_service_view.dart';
import '../features/auth/bindings/auth_binding.dart';
import '../features/auth/views/login_view.dart';
import '../features/auth/views/signup_view.dart';
import '../features/booking/bindings/booking_binding.dart';
import '../features/booking/views/booking_view.dart';
import '../features/booking_confirmation/bindings/booking_confirmation_binding.dart';
import '../features/booking_confirmation/views/booking_confirmation_view.dart';
import '../features/booking_details/bindings/booking_details_binding.dart';
import '../features/booking_details/views/booking_details_view.dart';
import '../features/chat/bindings/chat_binding.dart';
import '../features/chat/views/chat_detail_view.dart';
import '../features/chat/views/chat_list_view.dart';
import '../features/favorites/views/favorites_view.dart';
import '../features/main_nav/bindings/main_nav_binding.dart';
import '../features/main_nav/views/main_nav_view.dart';
import '../features/notifications/bindings/notifications_binding.dart';
import '../features/notifications/views/notifications_view.dart';
import '../features/onboarding/bindings/onboarding_binding.dart';
import '../features/onboarding/views/onboarding_view.dart';
import '../features/profile/bindings/edit_profile_binding.dart';
import '../features/profile/views/edit_profile_view.dart';
import '../features/provider_dashboard/bindings/provider_dashboard_binding.dart';
import '../features/provider_dashboard/views/provider_dashboard_view.dart';
import '../features/provider_details/bindings/provider_details_binding.dart';
import '../features/provider_details/views/provider_details_view.dart';
import '../features/provider_reviews/views/provider_reviews_view.dart';
import '../features/search/bindings/search_binding.dart';
import '../features/search/views/search_view.dart';
import '../features/service_details/bindings/service_details_binding.dart';
import '../features/service_details/views/service_details_view.dart';
import '../features/settings/bindings/settings_binding.dart';
import '../features/settings/views/settings_view.dart';
import '../features/splash/bindings/splash_binding.dart';
import '../features/splash/views/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.splash;

  static final routes = <GetPage>[
    GetPage(name: AppRoutes.splash, page: () => const SplashView(), binding: SplashBinding()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingView(), binding: OnboardingBinding()),
    GetPage(name: AppRoutes.login, page: () => const LoginView(), binding: LoginBinding()),
    GetPage(name: AppRoutes.signup, page: () => const SignupView(), binding: SignupBinding()),
    GetPage(name: AppRoutes.main, page: () => const MainNavView(), binding: MainNavBinding()),
    GetPage(name: AppRoutes.favorites, page: () => const FavoritesView()),
    GetPage(name: AppRoutes.search, page: () => const SearchView(), binding: SearchBinding()),
    GetPage(name: AppRoutes.serviceDetails, page: () => const ServiceDetailsView(), binding: ServiceDetailsBinding()),
    GetPage(name: AppRoutes.providerDetails, page: () => const ProviderDetailsView(), binding: ProviderDetailsBinding()),
    GetPage(name: AppRoutes.booking, page: () => const BookingView(), binding: BookingBinding()),
    GetPage(name: AppRoutes.bookingConfirmation, page: () => const BookingConfirmationView(), binding: BookingConfirmationBinding()),
    GetPage(name: AppRoutes.bookingDetails, page: () => const BookingDetailsView(), binding: BookingDetailsBinding()),
    GetPage(name: AppRoutes.chatList, page: () => const ChatListView(), binding: ChatListBinding()),
    GetPage(name: AppRoutes.chatDetail, page: () => const ChatDetailView(), binding: ChatDetailBinding()),
    GetPage(name: AppRoutes.notifications, page: () => const NotificationsView(), binding: NotificationsBinding()),
    GetPage(name: AppRoutes.editProfile, page: () => const EditProfileView(), binding: EditProfileBinding()),
    GetPage(name: AppRoutes.settings, page: () => const SettingsView(), binding: SettingsBinding()),
    GetPage(name: AppRoutes.providerDashboard, page: () => const ProviderDashboardShellView(), binding: ProviderDashboardBinding()),
    GetPage(name: AppRoutes.addEditService, page: () => const AddEditServiceView(), binding: AddEditServiceBinding()),
    GetPage(name: AppRoutes.providerReviews, page: () => const ProviderReviewsView()),
  ];
}
