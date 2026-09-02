import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/mock/mock_data.dart';
import '../../../data/models/chat_model.dart';

class ChatDetailController extends GetxController {
  late final ChatThreadModel thread;
  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  final TextEditingController inputController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    final threadId = Get.arguments as String;
    thread = MockData.chatThreads.firstWhere((t) => t.id == threadId);
    messages.assignAll(thread.messages);
  }

  @override
  void onClose() {
    inputController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void send() {
    final text = inputController.text.trim();
    if (text.isEmpty) return;
    messages.add(ChatMessageModel(id: 'local-${DateTime.now().millisecondsSinceEpoch}', text: text, time: DateTime.now(), isMe: true));
    inputController.clear();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 900), () {
      messages.add(ChatMessageModel(
        id: 'reply-${DateTime.now().millisecondsSinceEpoch}',
        text: 'Got it, thanks for letting me know!',
        time: DateTime.now(),
        isMe: false,
      ));
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 80), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
