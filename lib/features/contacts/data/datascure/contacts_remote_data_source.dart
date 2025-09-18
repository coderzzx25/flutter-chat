import 'dart:convert';

import 'package:flutter_chat/features/contacts/data/models/contacts_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ContactsRemoteDataSource {
  final String baseUrl;
  final _storage = FlutterSecureStorage();

  ContactsRemoteDataSource({required this.baseUrl});

  Future<List<ContactsModel>> fetchContacts() async {
    String token = await _storage.read(key: "token") ?? '';
    final response = await http.get(
      Uri.parse("$baseUrl/contact"),
      headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => ContactsModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch contacts");
    }
  }

  Future<void> addContact({required String email}) async {
    String token = await _storage.read(key: "token") ?? '';
    final response = await http.post(
      Uri.parse("$baseUrl/contact"),
      body: jsonEncode({"contactEmail": email}),
      headers: {
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to add contact");
    }
  }
}
