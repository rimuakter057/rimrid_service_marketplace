import 'package:get/get.dart';

import '../../../data/mock/mock_data.dart';
import '../../../data/models/review_model.dart';
import '../../provider_services/controllers/provider_services_controller.dart';

class ProviderReviewsController extends GetxController {
  List<ReviewModel> get reviews => MockData.reviewsByProvider(kMyProviderId);

  double get averageRating {
    if (reviews.isEmpty) return 0;
    return reviews.fold(0.0, (sum, r) => sum + r.rating) / reviews.length;
  }

  Map<int, int> get ratingBreakdown {
    final map = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (final r in reviews) {
      final bucket = r.rating.round().clamp(1, 5);
      map[bucket] = (map[bucket] ?? 0) + 1;
    }
    return map;
  }
}
