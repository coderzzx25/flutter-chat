import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/core/socket_service.dart';
import 'package:flutter_chat/features/chat/domian/entities/message_entity.dart';
import 'package:flutter_chat/features/chat/domian/usecases/fetch_message_use_case.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_event.dart';
import 'package:flutter_chat/features/chat/presentation/bloc/chat_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FetchMessageUseCase fetchMessageUseCase;
  final SocketService _socketService = SocketService();
  final List<MessageEntity> _messages = [];
  final _storage = FlutterSecureStorage();

  ChatBloc({required this.fetchMessageUseCase}) : super(ChatInitial()) {
    on<LoadMessageEvent>(_onLoadMessage);
    on<SendMessageEvent>(_onSendMessage);
    on<ReceiveMessageEvent>(_onReceiveMessage);
  }

  Future<void> _onLoadMessage(
    LoadMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());

    try {
      final message = await fetchMessageUseCase(event.conversationId);
      _messages.clear();
      _messages.addAll(message);
      emit(ChatSuccess(messages: List.from(message)));

      _socketService.socket.off('newMessage'); // 修复发送消息重复的问题

      _socketService.socket.emit('joinConversation', event.conversationId);
      _socketService.socket.on(
        'newMessage',
        (data) => {add(ReceiveMessageEvent(data))},
      );
    } catch (e) {
      emit(ChatError(message: 'Failed to load messages'));
    }
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    final senderId = await _storage.read(key: 'userId');
    var userId = int.tryParse(senderId ?? '') ?? 0;

    final newMessage = {
      'conversationId': event.conversationId,
      'context': event.content,
      'senderId': userId,
    };
    _socketService.socket.emit('sendMessage', newMessage);
  }

  Future<void> _onReceiveMessage(
    ReceiveMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    final message = MessageEntity(
      id: event.message['id'],
      content: event.message['content'],
      senderId: event.message['sender_id'],
      conversationId: event.message['conversation_id'],
      createAt: event.message['create_at'],
    );
    _messages.add(message);
    emit(ChatSuccess(messages: List.from(_messages)));
  }
}
