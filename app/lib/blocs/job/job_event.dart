import 'package:app/models/job.dart';
import 'package:app/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();
}

class JobLoad extends JobEvent {
  final User user;
  const JobLoad({this.user});

  @override
  List<Object> get props => [];
}

class JobCreate extends JobEvent {
  final Job job;
  final User user;

  const JobCreate(this.job, this.user);

  @override
  List<Object> get props => [job];

  @override
  String toString() => 'Job Created {job: $job}';
}

class JobUpdate extends JobEvent {
  final String id;
  final Job job;
  final User user;

  JobUpdate(this.id, this.job, this.user);

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
