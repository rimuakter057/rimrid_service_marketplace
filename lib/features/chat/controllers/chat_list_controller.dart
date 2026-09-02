import 'package:get/get.dart';

import '../../../data/mock/mock_data.dart';
import '../../../data/models/chat_model.dart';
import '../../../routes/app_routes.dart';

class ChatListController extends GetxController {
  List<ChatThreadModel> get threads =>
      List<ChatThreadModel>.from(MockData.chatThreads)..sort((a, b) => b.time.compareTo(a.time));

  void openThread(ChatThreadModel thread) => Get.toNamed(AppRoutes.chatDetail, arguments: thread.id);
}
