import 'package:app/models/application.dart';
import 'package:app/models/job.dart';
import 'package:app/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();
}

class ApplicationLoad extends ApplicationEvent {
  final Job job;
  final User user;
  const ApplicationLoad({this.job, this.user});

  @override
  List<Object> get props => [job, user];
}

class ApplicationCreate extends ApplicationEvent {
  final Application application;

  const ApplicationCreate(this.application);

  @override
  List<Object> get props => [application];

  @override
  String toString() => 'Application Created {application: $application}';
}

class ApplicationUpdate extends ApplicationEvent {
  final Application application;

  const ApplicationUpdate(this.application);

  @override
  List<Object> get props => [application];

  @override
  String toString() => 'Application Updated {application: $application}';
}

class ApplicationDelete extends ApplicationEvent {
  final Application application;
  final Job job;

  const ApplicationDelete(this.application, this.job);

  @override
  List<Object> get props => [application];

  @override
  String toString() => 'Application Deleted {application: $application}';
}
