import 'package:app/models/job.dart';
import 'package:equatable/equatable.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();
}

class JobLoad extends JobEvent {
  final String userType;
  final String companyId;
  const JobLoad({this.userType, this.companyId});

  @override
  List<Object> get props => [];
}

class JobCreate extends JobEvent {
  final Job job;
  final String userType;
  final String companyId;


  const JobCreate(this.job, {this.userType, this.companyId});

  @override
  List<Object> get props => [job];

  @override
  String toString() => 'Job Created {job: $job}';
}

class JobUpdate extends JobEvent {
  final String id;
  final Job job;
  final String userType;
  final String companyId;


  JobUpdate(this.id, this.job, {this.userType, this.companyId});

  @override
  List<Object> get props => [job];
  @override
  String toString() => 'Job Updated {job: $job}';
}

class JobDelete extends JobEvent {
  final Job job;

  JobDelete(this.job);
  @override
  List<Object> get props => [job];

  @override
  String toString() => 'Job Deleted {job: $job}';
}
