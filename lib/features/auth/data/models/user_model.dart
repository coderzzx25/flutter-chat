import 'package:flutter_chat/features/auth/domain/entities/user_entity.dart';

// TODO: token
class UserModel extends UserEntity {
  UserModel({
    required super.username,
    required super.email,
    required super.id,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      token: json['token'],
    );
  }
}
