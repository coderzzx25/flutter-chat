import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/features/contacts/domain/usecases/add_contacts_use_case.dart';
import 'package:flutter_chat/features/contacts/domain/usecases/fetch_contacts_use_case.dart';
import 'package:flutter_chat/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:flutter_chat/features/contacts/presentation/bloc/contacts_state.dart';
import 'package:flutter_chat/features/conversation/domain/usecases/check_or_create_conversation_use_case.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final FetchContactsUseCase fetchContactsUseCase;
  final AddContactsUseCase addContactsUseCase;
  final CheckOrCreateConversationUseCase checkOrCreateConversationUseCase;

  ContactsBloc({
    required this.fetchContactsUseCase,
    required this.addContactsUseCase,
    required this.checkOrCreateConversationUseCase,
  }) : super(ContactsInitial()) {
    on<FetchContactsEvent>(_onFetchContacts);
    on<AddContactEvent>(_onAddContact);
    on<CheckOrCreateConversationsEvent>(_onCheckOrCreateConversations);
  }

  Future<void> _onFetchContacts(
    FetchContactsEvent event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      final contacts = await fetchContactsUseCase();
      emit(ContactsSuccess(contacts));
    } catch (e) {
      emit(ContactsError('Failed to fetch contacts'));
    }
  }

  Future<void> _onAddContact(
    AddContactEvent event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoading());
    try {
      await addContactsUseCase(email: event.email);
      emit(ContactsAdded());
      add(FetchContactsEvent());
    } catch (e) {
      emit(ContactsError('Failed to add contact'));
    }
  }

  Future<void> _onCheckOrCreateConversations(
    CheckOrCreateConversationsEvent event,
    Emitter<ContactsState> emit,
  ) async {
    emit(ContactsLoading());

    try {
      final conversationId = await checkOrCreateConversationUseCase(
        contactId: event.contactId,
      );
      emit(
        ConversationReady(
          conversationId: conversationId,
          contactName: event.contactName,
        ),
      );
    } catch (e) {
      emit(ContactsError('Failed to create conversation'));
    }
  }
}
