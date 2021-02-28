import 'dart:convert';

import 'package:app/models/application.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApplicationDataProvider {
  final _baseUrl = 'http://10.0.2.2:3000/api/apply';
  final http.Client httpClient;

  ApplicationDataProvider({@required this.httpClient})
      : assert(httpClient != null);

  Future<String> getTokenFromStorage() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "jwt_token");
    return token;
  }

  Future<Application> createApplication(Application application) async {
    final token = getTokenFromStorage();

    final response = await httpClient.post(
      '$_baseUrl',
      headers: <String, String>{
        "authorization": "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'job_id': '602ab56bdade2735baf65105',
        'applicant_id': '602ab91cdade2735baf6510c',
        'company_id': '602ab8c2dade2735baf65109',
        'first_name': application.firstName,
        'last_name': application.lastName,
        'phone': application.phone,
        'email': application.email,
        'other_info': application.message,
      }),
    );

    if (response.statusCode == 200) {
      return Application.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Application.');
    }
  }

  Future<List<Application>> getApplications(String companyId) async {
    final response = await httpClient.get('$_baseUrl/company/$companyId');
    if (response.statusCode == 200) {
      final applications = jsonDecode(response.body) as List;
      return applications
          .map((application) => Application.fromJson(application))
          .toList();
    } else {
      throw Exception('Failed to load applications');
    }
  }

  Future<void> deleteApplication(String id) async {
    final http.Response response = await httpClient.delete(
      '$_baseUrl/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete application');
    }
  }

  Future<void> updateApplication(Application application) async {
    print(application.id);
    final http.Response response = await httpClient.patch(
      '$_baseUrl/${application.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': application.id,
        'job_id': '602ab56bdade2735baf65105',
        'applicant_id': '602ab91cdade2735baf6510c',
        'company_id': '602ab8c2dade2735baf65109',
        'first_name': application.firstName,
        'last_name': application.lastName,
        'phone': application.phone,
        'email': application.email,
        'other_info': application.message,
      }),
    );

    print(response);

    if (response.statusCode != 204) {
      throw Exception('Failed to update application');
    }
  }
}
