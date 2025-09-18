abstract class ChatEvent {}

class LoadMessageEvent extends ChatEvent {
  final int conversationId;
  LoadMessageEvent(this.conversationId);
}

class SendMessageEvent extends ChatEvent {
  final int conversationId;
  final String content;
  SendMessageEvent(this.conversationId, this.content);
}

class ReceiveMessageEvent extends ChatEvent {
  final Map<String, dynamic> message;
  ReceiveMessageEvent(this.message);
}
