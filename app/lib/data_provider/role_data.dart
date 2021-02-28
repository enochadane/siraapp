import 'dart:convert';
import 'dart:core';
import 'dart:ffi';

import 'package:app/models/role.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class RoleDataProvider {
  final _baseUrl = 'http://10.0.2.2:3000/api/roles';
  final http.Client httpClient;

  RoleDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Role> createRole(Role role) async {
    final response = await httpClient.post(
      '$_baseUrl',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': role.name,
      }),
    );

    if (response.statusCode == 200) {
      return Role.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Role');
    }
  }

  Future<List<Role>> getRoles() async {
    final response = await httpClient.get('$_baseUrl');

    if (response.statusCode == 200) {
      final roles = jsonDecode(response.body) as List;
      return roles.map((role) => Role.fromJson(role)).toList();
    } else {
      throw Exception('Failed to load roles');
    }
  }

  Future<void> deleteRole(String id) async {
    final http.Response response = await httpClient.delete(
      '$_baseUrl/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to delete role');
    }
  }
}
