import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Application extends Equatable {
  Application({
    this.id,
    this.jobId,
    this.applicantId,
    this.companyId,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.message,
  });

  final String id;
  final String jobId;
  final String applicantId;
  final String companyId;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String message;

  @override
  List<Object> get props => [
        id,
        jobId,
        applicantId,
        companyId,
        firstName,
        lastName,
        phone,
        email,
        message
      ];

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['_id'],
      jobId: json['job_id'],
      applicantId: json['applicant_id'],
      companyId: json['company_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      email: json['email'],
      message: json['other_info'],
    );
  }

  @override
  String toString() =>
      'Application {id: $id, jobId: $jobId, applicantId: $applicantId, companyId: $companyId, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, message: $message}';
}
