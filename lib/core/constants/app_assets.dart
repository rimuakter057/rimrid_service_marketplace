/// Placeholder remote-image sources used until real assets/CDN are wired up.
/// Centralizing the seed logic keeps mock data generation consistent.
class AppAssets {
  AppAssets._();

  static String serviceImage(String seed, {int width = 600, int height = 400}) =>
      'https://picsum.photos/seed/$seed/$width/$height';

  static String avatar(int seed) => 'https://i.pravatar.cc/150?img=$seed';
}
