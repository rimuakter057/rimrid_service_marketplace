class ReviewModel {
  final String id;
  final String userName;
  final int avatarSeed;
  final double rating;
  final String comment;
  final DateTime date;
  final String? serviceId;
  final String? providerId;
  final List<String> imageSeeds;

  const ReviewModel({
    required this.id,
    required this.userName,
    required this.avatarSeed,
    required this.rating,
    required this.comment,
    required this.date,
    this.serviceId,
    this.providerId,
    this.imageSeeds = const [],
  });
}
