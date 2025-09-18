import 'dart:convert';

import 'package:flutter_chat/features/chat/data/models/message_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MessageRemoteDataSource {
  final String baseUrl;
  final _storage = FlutterSecureStorage();

  MessageRemoteDataSource({required this.baseUrl});

  Future<List<MessageModel>> fetchMessage(int conversationId) async {
    String token = await _storage.read(key: "token") ?? "";

    final response = await http.get(
      Uri.parse("$baseUrl/message/$conversationId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => MessageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch messages');
    }
  }
}
