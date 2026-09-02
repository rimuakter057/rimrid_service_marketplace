import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class OnboardingPageData {
  final IconData icon;
  final String title;
  final String description;
  const OnboardingPageData({required this.icon, required this.title, required this.description});
}

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingPageData> pages = const [
    OnboardingPageData(
      icon: Icons.search_rounded,
      title: 'Find trusted pros',
      description: 'Browse verified cleaners, electricians, tutors and more, all in one place.',
    ),
    OnboardingPageData(
      icon: Icons.event_available_rounded,
      title: 'Book in seconds',
      description: 'Pick a time that works for you and confirm your booking instantly.',
    ),
    OnboardingPageData(
      icon: Icons.workspace_premium_rounded,
      title: 'Quality guaranteed',
      description: 'Every provider is rated and reviewed by real customers like you.',
    ),
  ];

  bool get isLastPage => currentPage.value == pages.length - 1;

  void onPageChanged(int index) => currentPage.value = index;

  void next() {
    if (isLastPage) {
      finish();
    } else {
      pageController.nextPage(duration: const Duration(milliseconds: 320), curve: Curves.easeOut);
    }
  }

  Future<void> finish() async {
    await StorageService.setOnboardingSeen();
    Get.offAllNamed(AppRoutes.login);
  }
}
