// 7
import 'package:flutter_chat/features/conversation/domain/entities/conversation_entity.dart';

abstract class ConversationState {}

class ConversationInitial extends ConversationState {}

class ConversationLoading extends ConversationState {}

class ConversationSuccess extends ConversationState {
  final List<ConversationEntity> conversationList;

  ConversationSuccess(this.conversationList);
}

class ConversationError extends ConversationState {
  final String message;

  ConversationError({required this.message});
}
