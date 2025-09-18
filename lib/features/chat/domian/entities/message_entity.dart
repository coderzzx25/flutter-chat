class MessageEntity {
  final int id;
  final String content;
  final int senderId;
  final int conversationId;
  final String createAt;

  MessageEntity({
    required this.id,
    required this.content,
    required this.senderId,
    required this.conversationId,
    required this.createAt,
  });
}
