import 'package:flutter_chat/features/chat/domian/entities/message_entity.dart';
import 'package:flutter_chat/features/chat/domian/repositories/message_repository.dart';

class FetchMessageUseCase {
  final MessageRepository messageRepository;

  FetchMessageUseCase({required this.messageRepository});

  Future<List<MessageEntity>> call(int conversationId) async {
    return await messageRepository.fetchMessages(conversationId);
  }
}
