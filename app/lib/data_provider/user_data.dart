import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  final _baseUrl = 'http://10.0.2.2:8383/api';

  Future<User> createUser(User user) async {
    final response = await http.post(
      '$_baseUrl',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': user.username,
        'email': user.email,
        'password': user.password
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create User');
    }
  }

  Future<List<User>> getUsers() async {
    try {
      final response = await http.get("$_baseUrl/users");
      if (response.statusCode == 200) {
        final users = jsonDecode(response.body) as List;
        return users.map((user) => User.fromJson(user)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (err) {
      print(err);
    }
  }

  Future<User> updateUserRole(String userId, String roleId ) async {
    final response = await http.put(
      '$_baseUrl/users/$userId/changerole',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'role_id': roleId,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create User');
    }
  }

  Future<void> deleteUser(String id) async {
    final http.Response response = await http.delete(
      '$_baseUrl/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to delete user');
    }
  }
}
