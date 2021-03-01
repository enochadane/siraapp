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


  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      jobPosition: json['job_position'],
      otherInfo: json['other_info'],
      experienceLevel: json['experience_level'],
      deadline: DateTime.parse(json['deadline']),
      categoryId: json['job_category_id'],
      jobType: json['job_type'],
      datePublished: DateTime.parse(json['date_published']),
      companyId: json['company_id'],
    );
  }

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
