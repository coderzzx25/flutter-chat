abstract class ContactsEvent {}

class FetchContactsEvent extends ContactsEvent {}

class CheckOrCreateConversationsEvent extends ContactsEvent {
  final int contactId;
  final String contactName;

  CheckOrCreateConversationsEvent(this.contactId, this.contactName);
}

class AddContactEvent extends ContactsEvent {
  final String email;

  AddContactEvent(this.email);
}
