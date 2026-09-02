import 'package:get/get.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/service_model.dart';

/// App-wide favorites state, kept alive for the whole session.
class FavoritesController extends GetxController {
  final RxSet<String> favoriteServiceIds = <String>{'s1', 's7'}.obs;

  bool isFavorite(String serviceId) => favoriteServiceIds.contains(serviceId);

  void toggle(String serviceId) {
    if (favoriteServiceIds.contains(serviceId)) {
      favoriteServiceIds.remove(serviceId);
    } else {
      favoriteServiceIds.add(serviceId);
    }
  }

  List<ServiceModel> get favoriteServices =>
      MockData.services.where((s) => favoriteServiceIds.contains(s.id)).toList();
}
