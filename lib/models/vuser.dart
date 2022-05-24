import 'package:viking_game/models/role.dart';

class VUser {
  final String name;
  final String username;
  final String? password;
  final Role role;

  VUser(
      {required this.name,
      required this.username,
      this.password,
      required this.role});

  factory VUser.fromJson(Map json) {
    return VUser(
        name: json['name'],
        username: json['username'],
        role: Role.fromJson(json['role']));
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
        'password': password,
        'role': role.toJson()
      }..removeWhere((key, value) => value == null);
}
