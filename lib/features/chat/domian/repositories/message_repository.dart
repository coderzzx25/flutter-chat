import 'package:flutter_chat/features/chat/domian/entities/message_entity.dart';

abstract class MessageRepository {
  Future<List<MessageEntity>> fetchMessages(int conversationId);

  Future<void> sendMessage(MessageEntity message);
}
