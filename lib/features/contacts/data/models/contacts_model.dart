import 'package:flutter_chat/features/contacts/domain/entities/contacts_entity.dart';

class ContactsModel extends ContactsEntity {
  ContactsModel({
    required super.id,
    required super.username,
    required super.email,
  });

  factory ContactsModel.fromJson(Map<String, dynamic> json) {
    return ContactsModel(
      id: json['contact_id'],
      username: json['username'],
      email: json['email'],
    );
  }
}
