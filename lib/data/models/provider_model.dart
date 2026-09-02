class ProviderModel {
  final String id;
  final String name;
  final int avatarSeed;
  final String profession;
  final double rating;
  final int reviewCount;
  final String bio;
  final int yearsExperience;
  final int completedJobs;
  final bool isVerified;
  final bool isOnline;
  final String location;
  final String responseTime;
  final List<String> serviceIds;
  final List<String> gallerySeeds;

  const ProviderModel({
    required this.id,
    required this.name,
    required this.avatarSeed,
    required this.profession,
    required this.rating,
    required this.reviewCount,
    required this.bio,
    required this.yearsExperience,
    required this.completedJobs,
    required this.isVerified,
    required this.isOnline,
    required this.location,
    required this.responseTime,
    required this.serviceIds,
    required this.gallerySeeds,
  });
}
