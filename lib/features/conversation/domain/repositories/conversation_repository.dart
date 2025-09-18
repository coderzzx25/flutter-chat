// 2
import 'package:flutter_chat/features/conversation/domain/entities/conversation_entity.dart';

abstract class ConversationRepository {
  Future<List<ConversationEntity>> fetchConversation();

  Future<int> checkOrCreateConversation({required int contactId});
}
