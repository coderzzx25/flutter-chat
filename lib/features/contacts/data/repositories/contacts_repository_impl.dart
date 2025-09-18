import 'package:flutter_chat/features/contacts/data/datascure/contacts_remote_data_source.dart';
import 'package:flutter_chat/features/contacts/domain/entities/contacts_entity.dart';
import 'package:flutter_chat/features/contacts/domain/repositories/contacts_repository.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final ContactsRemoteDataSource contactsRemoteDataSource;

  ContactsRepositoryImpl({required this.contactsRemoteDataSource});

  @override
  Future<void> addContact({required String email}) async {
    await contactsRemoteDataSource.addContact(email: email);
  }

  @override
  Future<List<ContactsEntity>> fetchContacts() async {
    return await contactsRemoteDataSource.fetchContacts();
  }
}
