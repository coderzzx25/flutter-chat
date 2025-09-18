// 5
import 'dart:convert';
import 'package:flutter_chat/features/conversation/data/models/conversation_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ConversationRemoteDataSource {
  final String baseUrl;
  final _storage = FlutterSecureStorage();

  ConversationRemoteDataSource({required this.baseUrl});

  Future<List<ConversationModel>> fetchConversation() async {
    String token = await _storage.read(key: 'token') ?? '';
    final response = await http.get(
      Uri.parse("$baseUrl/conversations"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => ConversationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch conversation');
    }
  }

  Future<int> checkOrCreateConversation(int contactId) async {
    String token = await _storage.read(key: 'token') ?? '';
    final response = await http.post(
      Uri.parse("$baseUrl/conversations/check-or-create"),
      body: jsonEncode({'contactId': contactId}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['conversationId'];
    } else {
      throw Exception('Failed to check or create conversation');
    }
  }
}
