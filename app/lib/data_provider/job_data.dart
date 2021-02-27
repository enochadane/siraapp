import 'dart:convert';

import 'package:app/models/job.dart';
import 'package:dio/dio.dart';
import "package:http/http.dart" as http;

class JobDataProvider {
  // final _baseUrl = 'http://localhost:8383/api/jobs';
  // final _baseUrl = "http://10.6.71.227:8383/api";
  final token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MDI4NTgwN2MzMTQ3OTdlMTVkZDQxOWYiLCJ1c2VybmFtZSI6ImF3ZWwiLCJlbWFpbCI6ImF3ZWxAZ21haWwuY29tIiwiaWF0IjoxNjEzNDIyOTc4LCJleHAiOjE2MTQyODY5Nzh9.sff9JfIBwtP7vqDbju-OKjt_7E5_0Y83YtzwMCvAT-w";

  final _baseUrl = "http://10.0.2.2:8383/api";

  final http.Client httpClient;
  final httpDioClient = new Dio();

  JobDataProvider({
    this.httpClient,
  });

  Future<Job> createJob(Job job) async {
    var data = {
      "name": job.name,
      "description": job.description,
      "other_info": job.otherInfo,
      "experience_level": job.experienceLevel,
      "job_position": job.jobPosition,
      "deadline": job.deadline.toString(),
      "job_type": job.jobType,
      "job_category_id": job.categoryId.toString(),
      "company_id": job.companyId,
      "date_published": job.datePublished.toString()
    };
    try {
      final response = await http.post("$_baseUrl/jobs",
          headers: <String, String>{
            "authorization": "Bearer $token",
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data));
      var jsonResponse = jsonDecode(response.body);
      print("response is $jsonResponse");

      if (response.statusCode == 201) {
        
        // return Job.fromMap(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create course.');
      }
    } catch (e) {
        print(e.toString());
        throw Exception('Failed to create course.');

    }
  }

  Future<List<Job>> getJobsByCategory(String categoryId) async {
    final response = await httpClient.get(
      Uri.http(_baseUrl, "/$categoryId/jobs"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200) {
      final jobs = jsonDecode(response.body) as List;
      return jobs.map((job) => Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  Future<List<Job>> getJobsByCompanyId(String companyId) async {
    final response = await httpClient.get("$_baseUrl/jobs/company/$companyId");

    if (response.statusCode == 200) {
      final jobs = jsonDecode(response.body) as List;
      print("${jobs.length} $jobs");
      List<Job> jobList = jobs.map((job) => Job.fromMap(job)).toList();

      return jobList;
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  Future<List<Job>> getJobs() async {
    final response = await httpClient.get("$_baseUrl/jobs");

    if (response.statusCode == 200) {
      final jobs = jsonDecode(response.body) as List;
      print("${jobs.length}");
      List<Job> jobList = jobs.map((job) => Job.fromMap(job)).toList();

      return jobList;
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  Future<Job> getJob(String id) async {
    final response = await httpClient.get("$_baseUrl/jobs/$id");

    if (response.statusCode == 200) {
      var job = jsonDecode(response.body);
      Job selectedjob = Job.fromMap(job);

      return selectedjob;
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  Future<Job> updateJob(String id, Job job) async {
    var data = {
      "name": job.name,
      "description": job.description,
      "other_info": job.otherInfo,
      "experience_level": job.experienceLevel,
      "job_position": job.jobPosition,
      "deadline": job.deadline.toString(),
      "job_type": job.jobType,
      "job_category_id": job.categoryId.toString(),
      "date_published": job.datePublished.toString(),
      "company_id": job.companyId
    };
    try {
      final response = await http.put("$_baseUrl/jobs/$id",
          headers: <String, String>{
            "authorization": "Bearer $token",
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data));
      var jsonResponse = jsonDecode(response.body);
      print("response is $jsonResponse");

      if (response.statusCode == 201) {
        return Job.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update course.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteJob(String id) async {
    final response = await httpClient.delete(
      "$_baseUrl/jobs/$id",
      headers: <String, String>{
        "authorization": "Bearer $token",
        'Content-Type': 'application/json',
      },
    );
    print("response status code is ${response.statusCode}");
    if (response.statusCode == 200) {
      // return Job.fromMap(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete job.');
    }
  }
}
