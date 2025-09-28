// 9
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/core/socket_service.dart';
import 'package:flutter_chat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_chat/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter_chat/features/conversation/data/datascure/conversation_remote_data_source.dart';
import 'package:flutter_chat/features/conversation/domain/usecases/fetch_conversation_use_case.dart';
import 'package:flutter_chat/features/conversation/presentation/bloc/conversation_event.dart';
import 'package:flutter_chat/features/conversation/presentation/bloc/conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final FetchConversationUseCase fetchConversationUseCase;
  final AuthBloc authBloc;
  final SocketService _socketService = SocketService();

  ConversationBloc({
    required this.fetchConversationUseCase,
    required this.authBloc,
  }) : super(ConversationInitial()) {
    on<FetchConversationEvent>(_onFetchConversations);
    _initializeSocketListeners();
  }

  void _initializeSocketListeners() {
    try {
      _socketService.socket.on('conversationUpdated', _onConversationUpdated);
      _socketService.socket.on('userStatus', _onUserStatusChanged);
      _socketService.socket.on('unreadCountUpdate', _onUnreadUpdated);
    } catch (e) {
      print('Error initializing socket listeners: $e');
    }
  }

  Future<void> _onFetchConversations(
    FetchConversationEvent event,
    Emitter<ConversationState> emit,
  ) async {
    emit(ConversationLoading());

    try {
      final conversations = await fetchConversationUseCase();
      emit(ConversationSuccess(conversations));
    } on UnauthorizedException {
      authBloc.add(LoggedOut());
      emit(ConversationError(message: 'Unauthorized'));
    } catch (e) {
      print('Error fetching conversations: $e');
      emit(ConversationError(message: 'Failed to load conversations'));
    }
  }

  void _onConversationUpdated(data) {
    add(FetchConversationEvent());
  }

  void _onUserStatusChanged(data) {
    add(FetchConversationEvent());
  }

  void _onUnreadUpdated(data) {
    add(FetchConversationEvent()); // 可优化成只更新特定对话的未读消息数
  }
}
