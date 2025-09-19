import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  late IO.Socket _socket;
  final _storage = FlutterSecureStorage();

  SocketService._internal() {
    initSocket();
  }

  Future<void> initSocket() async {
    String token = await _storage.read(key: 'token') ?? '';
    final senderId = await _storage.read(key: 'userId');
    var userId = int.tryParse(senderId ?? '') ?? 0;
    _socket = IO.io(
      'http://localhost:3000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) {
      print('connected');
      if (userId > 0) {
        _socket.emit('userOnline', userId);
      }
    });
  }

  IO.Socket get socket => _socket;
}
