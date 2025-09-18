import 'package:flutter_chat/features/contacts/domain/entities/contacts_entity.dart';

abstract class ContactsRepository {
  Future<List<ContactsEntity>> fetchContacts();

  Future<void> addContact({required String email});
}
