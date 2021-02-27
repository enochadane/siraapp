import 'dart:convert';

import "package:meta/meta.dart";
import 'package:equatable/equatable.dart';

class Job extends Equatable {
  final String id;
  final String name;
  final String description;
  final String jobPosition;
  final String otherInfo;
  final String experienceLevel;
  final DateTime deadline;
  final String categoryId;
  final String jobType;
  final DateTime datePublished;
  final String companyId;

  Job({
    this.id,
    @required this.name,
    @required this.description,
    @required this.jobPosition,
    @required this.otherInfo,
    @required this.experienceLevel,
    @required this.deadline,
    @required this.categoryId,
    @required this.jobType,
    @required this.datePublished,
    @required this.companyId,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'job_position': jobPosition,
      'other_info': otherInfo,
      'experience_level': experienceLevel,
      'deadline': deadline?.millisecondsSinceEpoch,
      'job_category_id': categoryId,
      'job_type': jobType,
      'date_published': datePublished?.millisecondsSinceEpoch,
      'company_id': companyId,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Job(
      id: map['_id'],
      name: map['name'],
      description: map['description'],
      jobPosition: map['job_position'],
      otherInfo: map['other_info'],
      experienceLevel: map['experience_level'],
      deadline: DateTime.parse(map['deadline']),
      categoryId: map['job_category_id'],
      jobType: map['job_type'],
      datePublished: DateTime.parse(map['date_published']),
      companyId: map['company_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Job.fromJson(String source) {
    print("$source is source data");
    return Job.fromMap(json.decode(source));
  }

  // factory Job.fromJson(Map<String, dynamic> json) {
  //    return Job(
  //     id: json['_id'],
  //     name: json['name'],
  //     description: json['description'],
  //     jobPosition: json['job_position'],
  //     otherInfo: json['other_info'],
  //     experienceLevel: json['experience_level'],
  //     deadline: DateTime.fromMillisecondsSinceEpoch(json['deadline']),
  //     categoryId: List<String>.from(json['job_category_id']),
  //     jobType: json['job_type'],
  //     datePublished: DateTime.fromMillisecondsSinceEpoch(json['date_published']),
  //     companyId: json['company_id'],
  //   );
  // }

  // @override
  // String toString() => 'Job { _id: $id, name: $name, description: $description, job_position: $jobPosition, other_info: $otherInfo, experience_level: $experienceLevel, job_category_id: $categoryId }';

  @override
  List<Object> get props => [
        id,
        name,
        description,
        jobPosition,
        otherInfo,
        experienceLevel,
        deadline,
        jobType,
        categoryId,
        datePublished,
        companyId
      ];
}
