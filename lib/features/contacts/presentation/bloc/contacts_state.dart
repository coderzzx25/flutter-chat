import 'package:flutter_chat/features/contacts/domain/entities/contacts_entity.dart';

abstract class ContactsState {}

class ContactsInitial extends ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsSuccess extends ContactsState {
  final List<ContactsEntity> contacts;

  ContactsSuccess(this.contacts);
}

class ContactsError extends ContactsState {
  final String message;

  ContactsError(this.message);
}

class ContactsAdded extends ContactsState {}

class ConversationReady extends ContactsState {
  final int conversationId;
  final String contactName;

  ConversationReady({required this.conversationId, required this.contactName});
}
