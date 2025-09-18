import 'package:flutter_chat/features/contacts/domain/entities/contacts_entity.dart';
import 'package:flutter_chat/features/contacts/domain/repositories/contacts_repository.dart';

class FetchContactsUseCase {
  final ContactsRepository contactsRepository;

  FetchContactsUseCase({required this.contactsRepository});

  Future<List<ContactsEntity>> call() async {
    return await contactsRepository.fetchContacts();
  }
}
