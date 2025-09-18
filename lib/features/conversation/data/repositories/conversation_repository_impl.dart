// 6
import 'package:flutter_chat/features/conversation/data/datascure/conversation_remote_data_source.dart';
import 'package:flutter_chat/features/conversation/domain/entities/conversation_entity.dart';
import 'package:flutter_chat/features/conversation/domain/repositories/conversation_repository.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource conversationRemoteDataSource;

  ConversationRepositoryImpl({required this.conversationRemoteDataSource});

  @override
  Future<List<ConversationEntity>> fetchConversation() async {
    return await conversationRemoteDataSource.fetchConversation();
  }

  @override
  Future<int> checkOrCreateConversation({required int contactId}) async {
    return await conversationRemoteDataSource.checkOrCreateConversation(
      contactId,
    );
  }
}
