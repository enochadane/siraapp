import 'dart:convert';
import 'dart:core';
import 'dart:ffi';

import 'package:app/models/role.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RoleDataProvider {
  String token;

  final _baseUrl = 'http://10.0.2.2:8383/api';

  RoleDataProvider({this.token});

  Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: "jwt_token");
    return "Bearer $token";
  }

  Future<Role> createRole(Role role) async {
    try {
      token = await getToken();
      // token =
          // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDNhODQ4NTYwOTBjMjMxMTE5MGFlYWUiLCJ1c2VybmFtZSI6Im5hdGhhbmllbCIsImVtYWlsIjoibmF0aGFuaWVsLmF3ZWxAZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwiaWF0IjoxNjE0NTkzOTcyLCJleHAiOjE2MTU0NTc5NzJ9.eAJhJ6jCsIcI5-H5YaAZS6JOdoS6q4ZKw_EGSOzLjxU';
      print("toke is $token");
      final response = await http.post(
        '$_baseUrl/roles',
        headers: <String, String>{
          "authorization": "$token",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': role.name.toUpperCase(),
        }),
      );

      if (response.statusCode == 200) {
        return Role.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create Role');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<List<Role>> getRoles() async {
    final response = await http.get('$_baseUrl/roles');

    if (response.statusCode == 200) {
      final roles = jsonDecode(response.body) as List;
      return roles.map((role) => Role.fromJson(role)).toList();
    } else {
      throw Exception('Failed to load roles');
    }
  }

  Future<void> deleteRole(String id) async {
    final http.Response response = await http.delete(
      '$_baseUrl/roles/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to delete role');
    }
  }
}
