import 'package:get/get.dart';

import '../controllers/chat_detail_controller.dart';
import '../controllers/chat_list_controller.dart';

class ChatListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatListController());
  }
}

class ChatDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatDetailController());
  }
}
