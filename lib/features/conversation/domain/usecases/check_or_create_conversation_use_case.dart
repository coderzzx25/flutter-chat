import 'package:flutter_chat/features/conversation/domain/repositories/conversation_repository.dart';

class CheckOrCreateConversationUseCase {
  final ConversationRepository conversationRepository;

  CheckOrCreateConversationUseCase({required this.conversationRepository});

  Future<int> call({required int contactId}) async {
    return conversationRepository.checkOrCreateConversation(
      contactId: contactId,
    );
  }
}
