import 'package:viking_game/models/role.dart';

class VUser {
  final String? id;
  final String name;
  final String username;
  final String? password;
  final Role role;

  VUser(
      {this.id,
      required this.name,
      required this.username,
      this.password,
      required this.role});

  factory VUser.fromJson(Map json) {
    return VUser(
        id: json['id'] ?? json['_id'],
        name: json['name'],
        username: json['username'],
        role: Role.fromJson(json['role']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'password': password,
        'role': role.toJson()
      }..removeWhere((key, value) => key == null || value == null);
}
