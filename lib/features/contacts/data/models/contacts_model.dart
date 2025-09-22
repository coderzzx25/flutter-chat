import 'package:flutter_chat/features/contacts/domain/entities/contacts_entity.dart';

class ContactsModel extends ContactsEntity {
  ContactsModel({
    required super.contactId,
    required super.username,
    required super.email,
  });

  factory ContactsModel.fromJson(Map<String, dynamic> json) {
    return ContactsModel(
      contactId: json['contact_id'],
      username: json['username'],
      email: json['email'],
    );
  }
}
