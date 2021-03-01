import 'dart:convert';

import 'package:app/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  final _baseUrl = 'http://10.0.2.2:8383/api';
  http.Client httpClient;
  String token;

  Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "jwt_token");
    return "Bearer $token";
  }

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
        final result = users.map((user) {
          var resultUser = User.fromJson(user);
          return resultUser;
        }).toList();
        print("is result ${result[0].role}");
        return result;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> updateUser(User user) async {
    token = await getToken();

    final http.Response response = await http.put(
      '$_baseUrl/users/${user.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": "$token",
      },
      body: jsonEncode(<String, dynamic>{
        'id': user.id,
        'username': user.username,
        'email': user.email,
        'password': user.password,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to update user');
    }
  }

  Future<User> updateUserRole(String userId, String roleId) async {
    token = await getToken();

    final response = await http.put(
      '$_baseUrl/users/$userId/changerole',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": "$token",
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
    token = await getToken();

    final http.Response response = await http.delete(
      '$_baseUrl/users/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": "$token",
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to delete user');
    }
  }
}
