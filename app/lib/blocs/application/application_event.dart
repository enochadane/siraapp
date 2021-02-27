import 'package:app/models/application.dart';
import 'package:equatable/equatable.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();
}

class ApplicationLoad extends ApplicationEvent {
  // final User user;
  // const ApplicationLoad(this.user);

  @override
  List<Object> get props => [];

  // List<Object> get props => [user];
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

  const ApplicationDelete(this.application);

  @override
  List<Object> get props => [application];

  @override
  String toString() => 'Application Deleted {application: $application}';
}
