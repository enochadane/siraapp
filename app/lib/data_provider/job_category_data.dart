import 'dart:convert';

import 'package:app/models/job_category.dart';
import "package:http/http.dart" as http;

class JobCategoryDataProvider {
  // final _baseUrl = 'http://localhost:8383/api/jobs';
  // final _baseUrl = "http://10.6.71.227:8383/api/jobs";

  final _baseUrl = "http://10.0.2.2:8383/api";

  final http.Client httpClient;
  JobCategoryDataProvider({
    this.httpClient,
  });

  Future<List<JobCategory>> getJobCategories() async {
    final response = await http.get("$_baseUrl/categories");
    if (response.statusCode == 200) {
      final jobCategories = jsonDecode(response.body) as List;
      List<JobCategory> jobCategoryList = jobCategories.map((category) => JobCategory.fromMap(category)).toList();

      return jobCategoryList;

    } else {
      throw Exception('Failed to load jobs');
    }
  }
}
