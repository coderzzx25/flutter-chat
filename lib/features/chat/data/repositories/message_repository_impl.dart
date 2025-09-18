import 'package:flutter_chat/features/chat/data/datascure/message_remote_data_source.dart';
import 'package:flutter_chat/features/chat/domian/entities/message_entity.dart';
import 'package:flutter_chat/features/chat/domian/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource messageRemoteDataSource;

  MessageRepositoryImpl({required this.messageRemoteDataSource});

  @override
  Future<List<MessageEntity>> fetchMessages(int conversationId) async {
    return await messageRemoteDataSource.fetchMessage(conversationId);
  }

  @override
  Future<void> sendMessage(MessageEntity message) {
    throw UnimplementedError();
  }
}
