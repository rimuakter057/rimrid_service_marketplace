class ChatMessageModel {
  final String id;
  final String text;
  final DateTime time;
  final bool isMe;

  const ChatMessageModel({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
  });
}

class ChatThreadModel {
  final String id;
  final String name;
  final int avatarSeed;
  final String lastMessage;
  final DateTime time;
  final int unreadCount;
  final bool isOnline;
  final List<ChatMessageModel> messages;

  const ChatThreadModel({
    required this.id,
    required this.name,
    required this.avatarSeed,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    required this.messages,
  });
}
