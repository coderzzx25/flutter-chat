import 'package:flutter_chat/features/chat/domian/entities/message_entity.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<MessageEntity> messages;

  ChatSuccess({required this.messages});
}

class ChatError extends ChatState {
  final String message;

  ChatError({required this.message});
}
