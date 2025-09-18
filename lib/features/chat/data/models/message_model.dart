import 'package:flutter_chat/features/chat/domian/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.conversationId,
    required super.content,
    required super.senderId,
    required super.createAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      conversationId: json['conversation_id'],
      content: json['content'],
      senderId: json['sender_id'],
      createAt: json['create_at'],
    );
  }
}
