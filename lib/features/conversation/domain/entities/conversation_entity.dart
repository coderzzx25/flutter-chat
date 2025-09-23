// 1
class ConversationEntity {
  final int id;
  final String participantName;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;
  final bool online;

  ConversationEntity({
    required this.id,
    required this.participantName,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.online,
  });
}
