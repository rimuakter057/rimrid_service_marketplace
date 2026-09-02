enum PriceUnit { hour, fixed, visit }

extension PriceUnitLabel on PriceUnit {
  String get label {
    switch (this) {
      case PriceUnit.hour:
        return '/hr';
      case PriceUnit.fixed:
        return ' fixed';
      case PriceUnit.visit:
        return '/visit';
    }
  }
}

class ServiceModel {
  final String id;
  final String title;
  final String categoryId;
  final String categoryName;
  final String providerId;
  final double price;
  final PriceUnit priceUnit;
  final double rating;
  final int reviewCount;
  final String imageSeed;
  final String description;
  final List<String> tags;
  final String duration;
  final String location;
  final bool isPopular;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.categoryName,
    required this.providerId,
    required this.price,
    required this.priceUnit,
    required this.rating,
    required this.reviewCount,
    required this.imageSeed,
    required this.description,
    required this.tags,
    required this.duration,
    required this.location,
    this.isPopular = false,
  });
}
