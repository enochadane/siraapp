import 'dart:convert';

import "package:meta/meta.dart";
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String role;
  final String email;
  final String password;
  User(
      {this.id,
      this.password,
      @required this.username,
      @required this.email,
      @required this.role});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'username': username,
      'role': role,
      'email': email,
      'password': password
    };
  }
  

  factory User.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    User user = User(
      id: map['_id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      role: map['role']??map['role_id']['name'],
    );
    print("user data is ${user.toJson()}");
    return user;
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props => [id, username, email, password, role];
}
